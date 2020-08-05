stop_server 'stop_server_install_dash' do
  only_if { File.exist?(node['wgisrv']['jaz_pid']) }
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/ui/Patches/3.1.3.0_201712110242/rollbackPatch.sh") }
  action :run
end

# install Cumulative Patch number ?
execute 'dash_cp' do
  command "#{node['wgisrv']['in_dir']}/3.1.3.0CumulativePatch007/applyPatch.sh \
  -username #{node['wgisrv']['was_act']} \
  -password #{node['wgisrv']['dash_pwd']} \
  -dashHome #{node['wgisrv']['jaz_dir']}/ui \
  -servername server1 \
  -profilename profile"
  cwd "#{node['wgisrv']['in_dir']}/3.1.3.0CumulativePatch007"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/ui/Patches/3.1.3.0_201712110242/rollbackPatch.sh") }
  action :run
end
