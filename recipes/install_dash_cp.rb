stop_server 'stop_server_install_dash' do
  server_cmd "#{node['wgisrv']['was_dir']}/bin/stopServer.sh server1 \
  -user #{node['wgisrv']['was_act']} \
  -password #{node['wgisrv']['dash_pwd']} -quiet"
  only_if { ::File.exist?(node['wgisrv']['jaz_pid']) }
  not_if { ::File.exist?("#{node['wgisrv']['jaz_dir']}/ui/Patches/3.1.3.0_201712110242/rollbackPatch.sh") }
  action :run
end

execute 'answer_dash_cp' do
  command 'echo "2">/tmp/cp7.txt'
  not_if { ::File.exist?("#{node['wgisrv']['temp_dir']}/cp7.txt") }
  action :run
end

# install Cumulative Patch number ?
execute 'dash_cp' do
  command "#{node['wgisrv']['in_dir']}/3.1.3.0CumulativePatch007/applyPatch.sh \
  -username #{node['wgisrv']['was_act']} \
  -password #{node['wgisrv']['dash_pwd']} \
  -dashHome #{node['wgisrv']['jaz_dir']}/ui \
  -servername server1 \
  -profilename profile < #{node['wgisrv']['temp_dir']}/cp7.txt"
  cwd "#{node['wgisrv']['in_dir']}/3.1.3.0CumulativePatch007"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
  only_if { ::File.exist?("#{node['wgisrv']['temp_dir']}/cp7.txt") }
  not_if { ::File.exist?("#{node['wgisrv']['jaz_dir']}/ui/Patches/3.1.3.0_201712110242/rollbackPatch.sh") }
  action :run
end
