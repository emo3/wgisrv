# fix Soap properties to not be prompted for password(s)
template "#{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props" do
  source 'soap.client.props.erb'
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  sensitive true
end

# encode passwords in file
execute 'encode_soap' do
  command "#{node['wgisrv']['jaz_dir']}/profile/bin/PropFilePasswordEncoder.sh \
  #{node['wgisrv']['jaz_dir']}/profile/properties/soap.client.props \
  com.ibm.loginPassword"
  cwd "#{node['wgisrv']['jaz_dir']}/profile/bin"
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  action :run
end
