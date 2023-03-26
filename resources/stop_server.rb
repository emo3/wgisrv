# you MUST enable SOAP to use stop_server function
provides :stop_server
unified_mode true

property :server_cmd, String, default: "#{node['wgisrv']['was_dir']}/bin/stopServer.sh server1 -quiet"
property :cmd_dir, String, default: "#{node['wgisrv']['was_dir']}/bin"
property :cmd_user, String, default: node['wgisrv']['nc_act']
property :cmd_group, String, default: node['wgisrv']['nc_grp']

action :run do
  # run the server command
  execute 'run_server_cmd' do
    command new_resource.server_cmd
    cwd new_resource.cmd_dir
    user new_resource.cmd_user
    group new_resource.cmd_group
    action :run
  end
end
