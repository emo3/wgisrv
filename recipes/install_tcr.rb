# create silent install file for tcr
template "#{node['wgisrv']['temp_dir']}/tcr.xml" do
  source 'tcr.xml.erb'
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/reporting/runcgi") }
  ## must be set because of clear text passwords
  sensitive true
  mode 0444
end

## stop JazzSM/Dash Server
stop_server 'stop_server_tcr' do
  only_if { File.exist?(node['wgisrv']['jaz_pid']) }
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/reporting/runcgi") }
  action :run
end
# Install tcr
execute 'install-tcr' do
  command "#{node['wgisrv']['app_dir']}/InstallationManager/eclipse/tools/imcl \
  input #{node['wgisrv']['temp_dir']}/tcr.xml \
  -log #{node['wgisrv']['temp_dir']}/tcr_log.xml \
  -acceptlicense"
  cwd "#{node['wgisrv']['app_dir']}/InstallationManager/eclipse/tools"
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/reporting/runcgi") }
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  umask '022'
  action :nothing
end

# remove silent install file
file "#{node['wgisrv']['temp_dir']}/tcr.xml" do
  action :nothing
end
