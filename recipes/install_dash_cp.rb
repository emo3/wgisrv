stop_server 'stop server' do
  action :run
end

# install Cumulative Patch number 5
execute 'dash_cp_5' do
  command "#{node['wgisrv']['in_dir']}/3.1.3.0CumulativePatch005/applyPatch.sh \
  -username #{node['wgisrv']['was_act']} \
  -password #{node['wgisrv']['dash_pwd']} \
  -dashHome #{node['wgisrv']['jaz_dir']}/ui \
  -servername server1 \
  -profilename profile"
  cwd "#{node['wgisrv']['in_dir']}/3.1.3.0CumulativePatch005"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end
