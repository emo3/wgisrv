# make a backup copy
stop_server 'copy soap' do
  only_if { File.exist?(node['wgisrv']['jaz_pid']) }
  action :run
end

copy_file 'copy soap' do
  old_file "#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props"
  file_ext '.bak'
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props.orig") }
  action :copy
end

# fix Soap properties to not be prompted for password(s)
template "#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props" do
  source 'soap.client.props.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props.orig") }
  sensitive true
end

# encode passwords in file
execute 'encode_soap' do
  command "#{node['wgisrv']['jaz_dir']}/profile/bin/PropFilePasswordEncoder.sh \
  #{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props \
  com.ibm.SOAP.loginPassword"
  cwd "#{node['wgisrv']['jaz_dir']}/profile/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props.orig") }
  action :run
end

copy_file 'rename soap' do
  old_file "#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props"
  file_ext '.bak'
  file_ext1 '.orig'
  action :move
end
