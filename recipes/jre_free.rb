# create shell variable for java
template '/etc/profile.d/java.sh' do
  source 'java.sh.erb'
  mode 0755
end

# change server.init
template "#{node['wgisrv']['ng_dir']}/omnibus_webgui/etc/server.init" do
  source 'server.init.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
end

## restart JazzSM/Dash Server
# stop wg
include_recipe '::stop_wg'
# start wg
include_recipe '::start_wg'
