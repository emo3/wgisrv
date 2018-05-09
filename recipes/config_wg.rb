# configure WebGUI to work with Netcool 8.1 Object Server
template "#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties" do
  source 'OMNIbusWebGUI.properties.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
end

# Configure files
execute 'config_wg' do
  command "#{node['wgisrv']['jaz_dir']}/profile/bin/PropFilePasswordEncoder.sh \
  #{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props \
  com.ibm.loginPassword"
  cwd "#{node['wgisrv']['jaz_dir']}/profile/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :nothing
end
