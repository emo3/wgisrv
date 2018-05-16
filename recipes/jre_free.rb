# create shell variable for java
template '/etc/profile.d/java.sh' do
  source 'java.sh.erb'
  mode 0755
end

# make a backup copy
file "#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init.orig" do
  content IO.read("#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init")
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init.orig") }
  action :create
end

# change server.init
template "#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init" do
  source 'server.init.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init.orig") }
end

## restart JazzSM/Dash Server
stop_server 'stop server jre free' do
  only_if { File.exist?(node['wgisrv']['jaz_pid']) }
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init.orig") }
  action :run
end
# start wg
execute 'start_wg_jre' do
  command "#{node['wgisrv']['was_dir']}/bin/startServer.sh server1 -quiet"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  not_if { File.exist?(node['wgisrv']['jaz_pid']) }
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init.orig") }
  action :run
end
