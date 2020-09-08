# create shell variable for java
template '/etc/profile.d/java.sh' do
  source 'java.sh.erb'
  mode 0755
end

# make a backup copy
copy_file 'copy_server_jre' do
  old_file "#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init"
  file_ext '.bak'
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init.orig") }
  action :copy
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
stop_server 'stop_server_jre_free' do
  server_cmd "#{node['wgisrv']['was_dir']}/bin/stopServer.sh server1 \
  -user #{node['wgisrv']['was_act']} \
  -password #{node['wgisrv']['dash_pwd']} -quiet"
  only_if { File.exist?(node['wgisrv']['jaz_pid']) }
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init.orig") }
  action :run
end
# start wg
execute 'start_wg_jre_free' do
  command "#{node['wgisrv']['was_dir']}/bin/startServer.sh server1 -quiet"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  not_if { File.exist?(node['wgisrv']['jaz_pid']) }
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init.orig") }
  action :nothing
end

# rename file
copy_file 'rename_server_jre_free' do
  old_file "#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init"
  file_ext '.bak'
  file_ext1 '.orig'
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init.orig") }
  action :move
end
