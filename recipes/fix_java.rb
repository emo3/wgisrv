# Set java 1.8
execute 'set Command Default' do
  command "#{node['wgisrv']['was_dir']}/bin/managesdk.sh \
  -setCommandDefault \
  -sdkName 1.8_64"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end

execute 'set New Profile Default' do
  command "#{node['wgisrv']['was_dir']}/bin/managesdk.sh \
  -setNewProfileDefault \
  -sdkName 1.8_64"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end

# Remove java 1.7
execute 'uninstall_java_1-7' do
  command "#{node['wgisrv']['was_dir']}/bin/managesdk.sh \
  -enableProfile \
  -profileName JazzSMProfile \
  -sdkName 1.8_64"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end
