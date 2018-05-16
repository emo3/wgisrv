# make backup copy of sdk
copy_file 'copy java' do
  old_file "#{node['wgisrv']['was_dir']}/properties/sdk/newProfileDefaultSDK.properties"
  file_ext '.bak'
  not_if { File.exist?("#{node['wgisrv']['was_dir']}/properties/sdk/newProfileDefaultSDK.properties.orig") }
  action :copy
end

# Set java 1.8
execute 'set Command Default' do
  command "#{node['wgisrv']['was_dir']}/bin/managesdk.sh \
  -setCommandDefault \
  -sdkName 1.8_64"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  not_if { File.exist?("#{node['wgisrv']['was_dir']}/properties/sdk/newProfileDefaultSDK.properties.orig") }
  action :run
end

execute 'set New Profile Default' do
  command "#{node['wgisrv']['was_dir']}/bin/managesdk.sh \
  -setNewProfileDefault \
  -sdkName 1.8_64"
  cwd "#{node['wgisrv']['was_dir']}/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  not_if { File.exist?("#{node['wgisrv']['was_dir']}/properties/sdk/newProfileDefaultSDK.properties.orig") }
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
  not_if { File.exist?("#{node['wgisrv']['was_dir']}/properties/sdk/newProfileDefaultSDK.properties.orig") }
  action :run
end

copy_file 'rename java' do
  old_file "#{node['wgisrv']['was_dir']}/properties/sdk/newProfileDefaultSDK.properties"
  file_ext '.bak'
  file_ext1 '.orig'
  action :move
end
