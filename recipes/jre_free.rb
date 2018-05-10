# create shell variable for java
template '/etc/profile.d/java.sh' do
  source 'java.sh.erb'
  mode 0755
end

# change server.init
template "#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init" do
  source 'server.init.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
end

## restart JazzSM/Dash Server
# stop JazzSM/Dash Server
execute 'stop_wg_jre' do
  command "#{node['wgisrv']['was_dir']}/bin/stopServer.sh server1 -quiet"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end
# start wg
execute 'start_wg_jre' do
  command "#{node['wgisrv']['was_dir']}/bin/startServer.sh server1 -quiet"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end
