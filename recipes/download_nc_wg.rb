# copy cp?
# copy wg 8.1.4
# copy wgfp 8.1.??
# copy jazz4sm 1.1.3.0
# copy wasfp 8.5.5.??
# copy java 8
# copy db2 client
# copy tcr
filelist = {
  '01' => { 'ipath' => node['wgisrv']['in_dir'], 'fname' => '1.1.3.0-TIV-JazzSM-DASH-Cumulative-Patch-0007.zip', 'ifile' => '3.1.3.0CumulativePatch007/applyPatch.sh', 'upack' => 'y' },
  '02' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wg", 'fname' => 'OMNIbus-v8.1.0.4-WebGUI.linux64.zip', 'ifile' => 'OMNIbusWebGUIRepository/repository.config', 'upack' => 'y' },
  '03' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wgfp", 'fname' => 'OMNIbus-v8.1.0-WebGUI-FP16-IM-Extensions-linux64-UpdatePack.zip', 'ifile' => 'OMNIbusWebGUIRepository/composite/repository.config', 'upack' => 'y' },
  '04' => { 'ipath' => "#{node['wgisrv']['in_dir']}/j4sm", 'fname' => 'JAZZ_FOR_SM_1.1.3.0_FOR_LNX.zip', 'ifile' => 'JazzSMRepository/disk1/diskTag.inf', 'upack' => 'y' },
  '05' => { 'ipath' => "#{node['wgisrv']['in_dir']}/was4j", 'fname' => 'WAS_V8.5.5.9_FOR_JSM_FOR_LINUX_ML.zip', 'ifile' => 'WASRepository/disk1/diskTag.inf', 'upack' => 'y' },
  '06' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wasfp", 'fname' => '8.5.5-WS-WAS-FP014-part1.zip', 'ifile' => 'repository.config', 'upack' => 'y' },
  '07' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wasfp", 'fname' => '8.5.5-WS-WAS-FP014-part2.zip', 'ifile' => 'native/com.ibm.was.shortcuts.linux_8.0.0.201808020949.zip', 'upack' => 'y' },
  '08' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wasfp", 'fname' => '8.5.5-WS-WAS-FP014-part3.zip', 'ifile' => 'native/com.ibm.websphere.embed.JDK8.32bit.jre_002_linux.ppc32_x_8.0.5017.201807270219.zip', 'upack' => 'y' },
  '09' => { 'ipath' => "#{node['wgisrv']['in_dir']}/java8", 'fname' => '8.0.4.5-WS-IBMWASJAVA-Linux.zip', 'ifile' => 'repository.config', 'upack' => 'y' },
  '10' => { 'ipath' => "#{node['wgisrv']['in_dir']}/db2c", 'fname' => 'v10.5fp9_linuxx64_client.tar.gz', 'ifile' => 'client/db2_install', 'upack' => 'y' },
  '11' => { 'ipath' => node['wgisrv']['in_dir'], 'fname' => 'ITCR_3.1.3.0_FOR_LINUX.tar.gz', 'ifile' => 'TCRCognos/build.txt', 'upack' => 'y' },
  '12' => { 'ipath' => node['wgisrv']['in_dir'], 'fname' => 'Netcool_OMNIbus.zip', 'ifile' => 'Netcool_OMNIbus.zip', 'upack' => 'n' },
  '13' => { 'ipath' => node['wgisrv']['in_dir'], 'fname' => 'Netcool_OMNIbus_updated.zip', 'ifile' => 'Netcool_OMNIbus_updated.zip', 'upack' => 'n' },
}

filelist.each do |_fn, fv|
  # Create install directory
  directory fv['ipath'] do
    recursive true
    user node['wgisrv']['nc_act']
    group node['wgisrv']['nc_grp']
    mode '0755'
    action :create
  end
  # Download file
  remote_file "#{fv['ipath']}/#{fv['fname']}" do
    source "#{node['wgisrv']['media_url']}/#{fv['fname']}"
    not_if { File.exist?("#{fv['ipath']}/#{fv['fname']}") }
    not_if { File.exist?("#{fv['ipath']}/#{fv['ifile']}") }
    user node['wgisrv']['nc_act']
    group node['wgisrv']['nc_grp']
    mode '0755'
    action :create
  end
  # un package file
  execute "un_package_#{fv['fname']}" do
    command "unzip -q #{fv['ipath']}/#{fv['fname']}" if File.extname("#{fv['ipath']}/#{fv['fname']}") == '.zip'
    command "tar -xf #{fv['ipath']}/#{fv['fname']}" if File.extname("#{fv['ipath']}/#{fv['fname']}") == '.tar'
    command "tar -zxf #{fv['ipath']}/#{fv['fname']}" if File.extname("#{fv['ipath']}/#{fv['fname']}") == '.gz'
    cwd fv['ipath']
    not_if { File.exist?("#{fv['ipath']}/#{fv['ifile']}") }
    not_if { fv['upack'] == 'n' }
    user node['wgisrv']['nc_act']
    group node['wgisrv']['nc_grp']
    umask '022'
    action :run
  end
  # remove package file
  file "#{fv['ipath']}/#{fv['fname']}" do
    not_if { fv['upack'] == 'n' }
    action :delete
  end
end
