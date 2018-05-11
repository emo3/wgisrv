# This will create .sh scripts to do stuff
# create dir to hold files
directory "#{node['wgisrv']['jaz_dir']}/scripts" do
  recursive true
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  mode '0755'
  action :create
end

scriptlist = [
  'add-users-roles',
  'add-users-roles1',
  'create_user',
  'encrypt',
  'list-admin',
  'list-dash',
  'list-isc',
]
scriptlist.each do |script|
  # write script
  template "#{script}.sh" do
    source "#{script}.sh.erb"
    user node['wgisrv']['nc_act']
    group node['wgisrv']['nc_grp']
    mode 0755
  end
end
