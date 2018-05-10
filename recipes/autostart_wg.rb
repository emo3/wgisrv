# create setup script for WebGUI applications
template '/etc/init.d/ncg' do
  source 'ncg.erb'
  mode 0755
end

# stop JazzSM/Dash Server
execute 'stop_wg_as' do
  command "#{node['wgisrv']['was_dir']}/bin/stopServer.sh server1 -quiet"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end

# add script to system configuration
service 'ncg' do
  action [:enable, :start]
end
