# create silent response file
template "#{node['wgisrv']['temp_dir']}/db2client_nr.rsp" do
  source 'db2client_nr.rsp.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  variables(
    sqllib_dir: "#{node['wgisrv']['ng_dir']}/sqllib",
    instance: node['wgisrv']['instance'],
    owner: node['wgisrv']['nc_act']
  )
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/OMNIbusWebGUI.properties.orig") }
end

# install DB2 client
execute 'install_db2_client' do
  command "#{node['wgisrv']['in_dir']}/db2c/client/db2setup \
  -u #{node['wgisrv']['temp_dir']}/db2client_nr.rsp \
  -l #{node['wgisrv']['temp_dir']}/db2client.log"
  cwd "#{node['wgisrv']['in_dir']}/db2c/client"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/ui/Patches/3.1.3.0_201712110242/rollbackPatch.sh") }
  action :run
end
