node.default['wgisrv']['filelist'] = {
  'wg' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wg",
   'fname' => 'OMNIbus-v8.1.0.4-WebGUI.linux64.zip',
   'ifile' => 'OMNIbusWebGUIRepository/repository.config',
   'version' => '8.1.4.201512041013',
   'upack' => 'y' },
  'wgfp' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wgfp",
   'fname' => 'OMNIbus-v8.1.0-WebGUI-FP19-IM-Extensions-linux64-UpdatePack.zip',
   'ifile' => 'OMNIbusWebGUIRepository/composite/repository.config',
   'version' => '8.1.19.202006112025',
   'upack' => 'y' },
  'j4sm' => { 'ipath' => "#{node['wgisrv']['in_dir']}/j4sm",
   'fname' => 'JAZZ_FOR_SM_1.1.3.0_FOR_LNX.zip',
   'ifile' => 'JazzSMRepository/disk1/diskTag.inf',
   'version' => '1.1.2001.20160606-1749',
   'upack' => 'y' },
  'jsmfp' => { 'ipath' => "#{node['wgisrv']['in_dir']}/jsmfp",
   'fname' => '1.1.3-TIV-JazzSM-multi-FP006.zip',
   'ifile' => 'JazzSMFPRepository/disk1/diskTag.inf',
   'version' => '3.1.3100.20200214-0518',
   'upack' => 'y' },
  'was4j' => { 'ipath' => "#{node['wgisrv']['in_dir']}/was4j",
   'fname' => 'WAS_V8.5.5.9_FOR_JSM_FOR_LINUX_ML.zip',
   'ifile' => 'WASRepository/disk1/diskTag.inf',
   'version' => '7.0.9030.20160224_1826',
   'upack' => 'y' },
  'wasfp1' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wasfp",
   'fname' => '8.5.5-WS-WAS-FP017-part1.zip',
   'ifile' => 'repository.config',
   'version' => '8.5.5017.20200205_1450',
   'upack' => 'y' },
  'wasfp2' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wasfp",
   'fname' => '8.5.5-WS-WAS-FP017-part2.zip',
   'ifile' => 'native/com.ibm.was.shortcuts.linux_8.0.0.202002051407.zip',
   'upack' => 'y' },
  'wasfp3' => { 'ipath' => "#{node['wgisrv']['in_dir']}/wasfp",
   'fname' => '8.5.5-WS-WAS-FP017-part3.zip',
   'ifile' => 'native/com.ibm.websphere.embed.JDK8.32bit.jre_002_linux.ppc32_x_8.0.6000.202002051822.zip',
   'upack' => 'y' },
  'java8' => { 'ipath' => "#{node['wgisrv']['in_dir']}/java8",
   'fname' => '8.0.4.5-WS-IBMWASJAVA-Linux.zip',
   'ifile' => 'repository.config',
   'version' => '8.0.4005.20170626_0627',
   'upack' => 'y' },
  'db2c' => { 'ipath' => "#{node['wgisrv']['in_dir']}/db2c",
   'fname' => 'v10.5fp9_linuxx64_client.tar.gz',
   'ifile' => 'client/db2_install',
   'upack' => 'y' },
  'tcr' => { 'ipath' => "#{node['wgisrv']['in_dir']}/tcr",
   'fname' => 'ITCR_3.1.3.0_FOR_LINUX.tar.gz',
   'ifile' => 'TCRCognos/build.txt',
   'version' => '3.1.3100.20200214-0518',
   'upack' => 'y' },
  'nc' => { 'ipath' => node['wgisrv']['in_dir'],
   'fname' => 'Netcool_OMNIbus_updated.zip',
   'ifile' => 'Netcool_OMNIbus_updated.zip',
   'upack' => 'n' },
}

# add needed TCR  package(s)
package node['wgisrv']['packages']
package node['wgisrv']['packages1']
# package node['wgisrv']['packages2']

# Create media directory
directory node['wgisrv']['media_dir'] do
  recursive true
  user node['wgisrv']['nc_act']
  group node['wgisrv']['nc_grp']
  mode '0755'
  action :create
end

node['wgisrv']['filelist'].each do |_fn, fv|
  # Create install directory
  directory fv['ipath'] do
    recursive true
    user node['wgisrv']['nc_act']
    group node['wgisrv']['nc_grp']
    mode '0755'
    action :create
  end
  # Download file
  remote_file "#{node['wgisrv']['media_dir']}/#{fv['fname']}" do
    source "#{node['wgisrv']['media_url']}/#{fv['fname']}"
    user node['wgisrv']['nc_act']
    group node['wgisrv']['nc_grp']
    mode '0755'
    action :create
  end
  # unpackage file
  archive_file fv['fname'] do
    owner node['wgisrv']['nc_act']
    group node['wgisrv']['nc_grp']
    path "#{node['wgisrv']['media_dir']}/#{fv['fname']}"
    destination fv['ipath']
    overwrite :auto
    action :extract
    not_if { fv['upack'] == 'n' }
  end
end
