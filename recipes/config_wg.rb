set_hostname 'set chefsrv server' do
  action :run
end

# set the IP and ObjServ name
set_hostname 'set ObjSrv server' do
  host_ip   node['wgisrv']['OSP']
  host_name node['wgisrv']['OS']
  action :run
end

# set the IP and Database name
set_hostname 'set Database server' do
  host_ip   node['wgisrv']['DSP']
  host_name node['wgisrv']['DS']
  action :run
end

# make backup copy of WebGUI
copy_file 'copy WebGUI' do
  old_file "#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties"
  file_ext '.bak'
  not_if { ::File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties.orig") }
  action :copy
end

# configure WebGUI to work with Netcool 8.1 Object Server
template "#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties" do
  source 'OMNIbusWebGUI.properties.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
  not_if { ::File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties.orig") }
end

# Configure files
execute 'config_wg' do
  command "#{node['wgisrv']['jaz_dir']}/profile/bin/ws_ant.sh configureOS"
  cwd "#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  not_if { ::File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties.orig") }
  action :run
end

# rename WebGUI
copy_file 'rename WebGUI' do
  old_file "#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties"
  file_ext '.bak'
  file_ext1 '.orig'
  not_if { ::File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties.orig") }
  action :move
end
