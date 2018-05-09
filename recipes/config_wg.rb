# configure WebGUI to work with Netcool 8.1 Object Server
template "#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties" do
  source 'OMNIbusWebGUI.properties.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
end

# Configure files
execute 'config_wg' do
  command "#{node['wgisrv']['jaz_dir']}/profile/bin/ws_ant.sh configureOS"
  cwd "#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end
