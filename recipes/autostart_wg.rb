# create setup script for WebGUI applications
template '/etc/init.d/ncg' do
  source 'ncg.erb'
  mode 0755
end

# add script to system configuration
service 'ncg' do
  action [:enable, :start]
end
