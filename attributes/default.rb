default['wgisrv']['cots_dir']    = '/sfcots'
default['wgisrv']['app_dir']     = "#{node['wgisrv']['cots_dir']}/apps"
default['wgisrv']['ng_dir']      = "#{node['wgisrv']['app_dir']}/netcool"
default['wgisrv']['in_dir']      = "#{node['wgisrv']['app_dir']}/install"
default['wgisrv']['temp_dir']    = '/tmp'
default['wgisrv']['media_url']   = 'http://10.1.1.30/media'
default['wgisrv']['nc_act']      = 'netcool'
default['wgisrv']['nc_grp']      = 'ncoadmin'
default['wgisrv']['root_pwd']    = 'nc0Adm1n'
default['wgisrv']['pa_epwd']     = '@44:GlEwL3cFaU+Pfjcm5S7xNs00PubYXnWhTqEVDtgvUjo=@'
default['wgisrv']['encryption']  = 'AES'
# Taken from environmental variables via .kitchen.yml
default['PAP']                   = ''
default['PA']                    = ''
