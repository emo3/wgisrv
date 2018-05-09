# stop JazzSM/Dash Server
execute 'stop_wg' do
  command "#{node['wgisrv']['was_dir']}/bin/stopServer.sh server1 -quiet"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end
