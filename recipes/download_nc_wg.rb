# copy cp1 - cp5
# copy java 8
# copy wg 8.1.4
# copy wgfp 8.1.12
# copy wasfp 8.5.5.12
# copy jazz4sm 1.1.3.0
# Download the cp files
filelist = {
  '01' => { 'ipath' => node['wgisrv']['in_dir'], 'fname' => '1.1.3.0-TIV-JazzSM-DASH-Cumulative-Patch-0001.zip', 'ifile' => '3.1.3.0CumulativePatch1/applyPatch.sh' },
  '02' => { 'ipath' => node['wgisrv']['in_dir'], 'fname' => '1.1.3.0-TIV-JazzSM-DASH-Cumulative-Patch-0002.zip', 'ifile' => '3.1.3.0CumulativePatch2/applyPatch.sh' },
  '03' => { 'ipath' => node['wgisrv']['in_dir'], 'fname' => '1.1.3.0-TIV-JazzSM-DASH-Cumulative-Patch-0003.zip', 'ifile' => '3.1.3.0CumulativePatch003/applyPatch.sh' },
  '04' => { 'ipath' => node['wgisrv']['in_dir'], 'fname' => '1.1.3.0-TIV-JazzSM-DASH-Cumulative-Patch-0004.zip', 'ifile' => '3.1.3.0CumulativePatch004/applyPatch.sh' },
  '05' => { 'ipath' => node['wgisrv']['in_dir'], 'fname' => '1.1.3.0-TIV-JazzSM-DASH-Cumulative-Patch-0005.zip', 'ifile' => '3.1.3.0CumulativePatch005/applyPatch.sh' },
  '06' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wg", 'fname' => 'OMNIbus-v8.1.0.4-WebGUI.linux64.zip', 'ifile' => 'OMNIbusWebGUIRepository/repository.config' },
  '07' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wgfp", 'fname' => 'OMNIbus-v8.1.0-WebGUI-FP12-IM-Extensions-linux64-UpdatePack.zip', 'ifile' => 'OMNIbusWebGUIRepository/composite/repository.config' },
  '08' => { 'ipath' => "#{node['wgisrv']['in_dir']}/j4sm", 'fname' => 'JAZZ_FOR_SM_1.1.3.0_FOR_LNX.zip', 'ifile' => 'JazzSMRepository/disk1/diskTag.inf' },
  '09' => { 'ipath' => "#{node['wgisrv']['in_dir']}/was4j", 'fname' => 'WAS_V8.5.5.9_FOR_JSM_FOR_LINUX_ML.zip', 'ifile' => 'WASRepository/disk1/diskTag.inf' },
  '10' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wasfp", 'fname' => '8.5.5-WS-WAS-FP012-part1.zip', 'ifile' => 'repository.config' },
  '11' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wasfp", 'fname' => '8.5.5-WS-WAS-FP012-part2.zip', 'ifile' => 'native/com.ibm.was.shortcuts.linux_8.0.0.201706270952.zip' },
  '12' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wasfp", 'fname' => '8.5.5-WS-WAS-FP012-part3.zip', 'ifile' => 'native/com.ibm.websphere.embed.JDK8.32bit.jre_002_linux.ppc32_x_8.0.4005.201706261127.zip' },
  '13' => { 'ipath' => "#{node['wgisrv']['in_dir']}/java8", 'fname' => '8.0.4.5-WS-IBMWASJAVA-Linux.zip', 'ifile' => 'repository.config' },
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
  # unzip file
  execute "unzip_package_#{fv['fname']}" do
    command "unzip -q #{fv['ipath']}/#{fv['fname']}"
    cwd fv['ipath']
    not_if { File.exist?("#{fv['ipath']}/#{fv['ifile']}") }
    user node['wgisrv']['nc_act']
    group node['wgisrv']['nc_grp']
    umask '022'
    action :run
  end
  # remove zip
  file "#{fv['ipath']}/#{fv['fname']}" do
    action :delete
  end
end