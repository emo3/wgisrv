default['wgisrv']['cots_dir']  = '/sfcots'
default['wgisrv']['app_dir']   = "#{node['wgisrv']['cots_dir']}/apps"
default['wgisrv']['ng_dir']    = "#{node['wgisrv']['app_dir']}/netcool"
default['wgisrv']['in_dir']    = "#{node['wgisrv']['app_dir']}/install"
default['wgisrv']['was_dir']   = "#{node['wgisrv']['app_dir']}/WebSphere/AppServer"
default['wgisrv']['temp_dir']  = '/tmp'
default['wgisrv']['media_url'] = 'http://10.1.1.30/media'
default['wgisrv']['nc_act']    = 'netcool'
default['wgisrv']['nc_grp']    = 'ncoadmin'
default['wgisrv']['was_epwd']  = 'AjEXH\/Rc1xpV0MEsp3EhHQ=='
default['wgisrv']['dash_pwd']  = 'c@tch-22'
# Taken from environmental variables via .kitchen.yml
default['PAP']                 = ''
default['PA']                  = ''
