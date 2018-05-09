node.default['nc_base']['cots_dir'] = '/sfcots'
node.default['nc_base']['app_dir']  = "#{node['nc_base']['cots_dir']}/apps"
include_recipe 'nc_base::create_nc_acct'
include_recipe 'nc_base::nc_filesystem'
include_recipe 'nc_base::install_im'
include_recipe 'nc_base::fix_nc_base'
include_recipe 'nc_base::add_x11'
include_recipe '::download_nc_wg'
include_recipe '::install_nc_wg'
