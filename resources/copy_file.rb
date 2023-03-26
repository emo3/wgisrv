provides :copy_file
unified_mode true

property :old_file, String, default: ''
property :file_ext, String, default: '.bak'
property :file_ext1, String, default: ''

action :copy do
  # make a backup copy of file
  execute "copy_file-#{new_resource.old_file}" do
    command "cp -a #{new_resource.old_file} #{new_resource.old_file}#{new_resource.file_ext}"
    not_if { ::File.exist?("#{new_resource.old_file}#{new_resource.file_ext}") }
    action :run
  end
end

action :move do
  # rename a file
  execute "rename_file-#{new_resource.old_file}" do
    command "mv -f #{new_resource.old_file}#{new_resource.file_ext} #{new_resource.old_file}#{new_resource.file_ext1}"
    not_if { ::File.exist?("#{new_resource.old_file}#{new_resource.file_ext1}") }
    action :run
  end
end
