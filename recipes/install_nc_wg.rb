# add needed TCR  package(s)
package node['wgisrv']['packages']

# create silent install file for WebGUI packages
template "#{node['wgisrv']['temp_dir']}/wg.xml" do
  source 'wg.xml.erb'
  variables(
    was85v:   node['wgisrv']['filelist']['j4sm']['version'],
    wasbasev: node['wgisrv']['filelist']['wasfp1']['version'],
    java7v:   node['wgisrv']['filelist']['was4j']['version'],
    java8v:   node['wgisrv']['filelist']['java8']['version'],
    j4smv:    node['wgisrv']['filelist']['jsmfp']['version'],
    webguiv:  node['wgisrv']['filelist']['wgfp']['version'],
    reportv:  node['wgisrv']['filelist']['tcr']['version']
  )
  not_if { ::File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/runcgi") }
  ## must be set because of clear text passwords
  sensitive true
  mode '0444'
end

# Install webgui
execute 'install_wg' do
  command "#{node['wgisrv']['app_dir']}/InstallationManager/eclipse/tools/imcl \
  input #{node['wgisrv']['temp_dir']}/wg.xml \
  -log #{node['wgisrv']['temp_dir']}/wg_log.xml \
  -acceptlicense"
  cwd "#{node['wgisrv']['app_dir']}/InstallationManager/eclipse/tools"
  not_if { ::File.exist?("#{node['wgisrv']['ng_dir']}/omnibus_webgui/bin/runcgi") }
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  umask '022'
  action :run
end

# create shell variable for WebGUI
template '/etc/profile.d/webgui.sh' do
  source 'webgui.sh.erb'
  mode '0755'
end

# remove silent install file
file "#{node['wgisrv']['temp_dir']}/wg.xml" do
  action :delete
end
