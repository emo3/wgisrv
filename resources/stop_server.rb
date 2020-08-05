# you MUST enable SOAP to use stop_server function
resource_name :stop_server

property :server_cmd, String, default: "#{node['wgisrv']['was_dir']}/bin/stopServer.sh server1 -quiet"
property :cmd_dir, String, default: "#{node['wgisrv']['was_dir']}/bin"
property :cmd_user, String, default: node['wgisrv']['nc_act']
property :cmd_group, String, default: node['wgisrv']['nc_grp']
property :cmd_sensitive, String, default: 'false'

action :run do
  # run the server command
  execute 'run_server_cmd' do
    command new_resource.server_cmd
    cwd new_resource.cmd_dir
    user new_resource.cmd_user
    group new_resource.cmd_group
    sensitive new_resource.cmd_sensitive
    action :run
  end
end
