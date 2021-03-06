#################################################################
# Create directories
directory node['wgisrv']['app_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

package 'lvm2'

create_xfs 'create netcool wg extra file system' do
  lv_size   node['wgisrv']['lv_size']
  lv_name   node['wgisrv']['lv_name']
  mnt_point node['wgisrv']['app_dir']
  action :run
end
