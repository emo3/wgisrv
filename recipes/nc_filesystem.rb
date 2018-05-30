#################################################################
# Create directories
directory node['wgisrv']['app_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

#################################################################
# Set physical volume
lvm_physical_volume '/dev/sdb'

#################################################################
# Set volume group
lvm_volume_group 'ncvg' do
  physical_volumes ['/dev/sdb']
end

#################################################################
# Set logical volume
lvm_logical_volume 'lvnc' do
  group 'ncvg'
  size '60G'
  filesystem 'xfs'
  mount_point node['wgisrv']['app_dir']
end
