# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'wgisrv'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'wgisrv::make_nc_wg'

# Specify a custom source for a single cookbook:
cookbook 'wgisrv',       path: '.'
cookbook 'nc_base',      git: 'https://github.com/emo3/nc_base.git'
cookbook 'server_utils', git: 'https://github.com/emo3/server_utils.git'
