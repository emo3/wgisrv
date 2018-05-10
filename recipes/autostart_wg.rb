# create setup script for WebGUI applications
template '/etc/init.d/ncg' do
  source 'ncg.erb'
  mode 0755
end

# stop wg
include_recipe '::stop_wg'

# add script to system configuration
service 'ncg' do
  action [:enable, :start]
end
