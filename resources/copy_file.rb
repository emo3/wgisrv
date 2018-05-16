resource_name :copy_file

property :old_file, String, default: ''

action :run do
  # make a backup copy of file
  execute 'backup_file' do
    command "cp #{new_resource.old_file} #{new_resource.old_file}.orig"
    user new_resource.cmd_user
    group new_resource.cmd_group
    not_if { File.exist?("#{new_resource.old_file}.orig") }
    action :run
  end
end
