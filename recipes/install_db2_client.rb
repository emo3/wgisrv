package %w(pam.i686)

log "#{node['wgisrv']['nc_home']}/sqllib"
# create silent response file
template "#{node['wgisrv']['temp_dir']}/db2client_nr.rsp" do
  source 'db2client_nr.rsp.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  variables(
    sqllib_dir: node['wgisrv']['ng_home'],
    instance: node['wgisrv']['instance'],
    owner: node['wgisrv']['nc_act']
  )
  not_if { File.exist?("#{node['wgisrv']['nc_home']}/sqllib/db2profile") }
end

# install DB2 client
execute 'install_db2_client' do
  command "#{node['wgisrv']['in_dir']}/db2c/client/db2setup \
  -u #{node['wgisrv']['temp_dir']}/db2client_nr.rsp \
  -l #{node['wgisrv']['temp_dir']}/db2client.log"
  cwd "#{node['wgisrv']['in_dir']}/db2c/client"
  user 'root'
  group node['wgisrv']['nc_grp']
  not_if { File.exist?("#{node['wgisrv']['nc_home']}/sqllib/db2profile") }
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
    dbserver: node['wgisrv']['DSP'],
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
  # not_if { File.exist?("#{node['wgisrv']['nc_home']}/sqllib/db2profile") }
  action :run
end

# remove sql file
file "#{node['wgisrv']['temp_dir']}/catalog.sql" do
  action :delete
end
