# create setup script for WebGUI applications
template '/etc/init.d/ncg' do
  source 'ncg.erb'
  mode 0755
end

# stop JazzSM/Dash Server
stop_server 'stop_server_auto' do
  only_if { File.exist?(node['wgisrv']['jaz_pid']) }
  action :run
end

# add script to system configuration
service 'ncg' do
  action [:enable, :start]
end
