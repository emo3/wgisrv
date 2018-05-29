package %w(pam.i686)

# create silent response file
template "#{node['wgisrv']['temp_dir']}/db2client_nr.rsp" do
  source 'db2client_nr.rsp.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  variables(
    sqllib_dir: "#{node['wgisrv']['nc_home']}/sqllib",
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
  action :delete
end

# update netcool account bash profile
template "#{node['wgisrv']['nc_home']}/.bash_profile" do
  source 'nc_bash_profile.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
end

# create sql file to catalog nodes
template "#{node['wgisrv']['temp_dir']}/catalog.sql" do
  source 'db2_catalog.sql.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  variables(
    dbnode: 'TDWNODE',
    dbserver: node['DS'],
    dbport: '60008',
    tcr_db: 'TCRDB',
    rpt_db: 'REPORTER'
  )
end

# run DB2 sql commands
execute 'db2_catalog' do
  command "#{node['wgisrv']['nc_home']}/sqllib/bin/db2 \
  -tmf #{node['wgisrv']['temp_dir']}/catalog.sql"
  cwd "#{node['wgisrv']['nc_home']}/sqllib/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end

# remove sql file
file "#{node['wgisrv']['temp_dir']}/catalog.sql" do
  action :delete
end

# create TCR content store sql
template "#{node['wgisrv']['temp_dir']}/tcr.sql" do
  source 'tcr.sql.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  variables(
    tcr_db: 'TCRDB',
    tcr_user: 'tcr001',
    tcr_pwd: 'P@ssw0rd'
  )
end

# run DB2 sql commands to create content store
execute 'db2_tcr' do
  command "#{node['wgisrv']['nc_home']}/sqllib/bin/db2 \
  -tmf #{node['wgisrv']['temp_dir']}/tcr.sql"
  cwd "#{node['wgisrv']['nc_home']}/sqllib/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :nothing
end

# remove sql file
file "#{node['wgisrv']['temp_dir']}/tcr.sql" do
  action :nothing
end
