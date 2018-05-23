# make sure the $HOME dir of netcool accout is 755
directory "/home/#{node['wgisrv']['nc_act']}" do
  recursive true
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  mode '0755'
  action :create
end

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
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/sqllib/db2dump") }
end

# install DB2 client
execute 'install_db2_client' do
  command "#{node['wgisrv']['in_dir']}/db2c/client/db2setup \
  -u #{node['wgisrv']['temp_dir']}/db2client_nr.rsp \
  -l #{node['wgisrv']['temp_dir']}/db2client.log"
  cwd "#{node['wgisrv']['in_dir']}/db2c/client"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  not_if { File.exist?("#{node['wgisrv']['ng_dir']}/sqllib/db2dump") }
  action :run
end

# remove response file
file "#{node['wgisrv']['temp_dir']}/db2client_nr.rsp" do
  action :nothing
end
