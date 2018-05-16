# make a backup copy
file "#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props.orig" do
  content IO.read("#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props")
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props.orig") }
  action :create
end

# fix Soap properties to not be prompted for password(s)
template "#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props" do
  source 'soap.client.props.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
  not_if { File.exist?("#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props.orig") }
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
