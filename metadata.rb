name 'wgisrv'
maintainer 'Ed Overton'
maintainer_email 'e.overton@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures wgisrv'
long_description 'Installs/Configures wgisrv'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)
supports 'redhat'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/wgisrv/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/wgisrv'
depends 'delivery-truck'
depends 'nc_base', '~> 0.1.0'
depends 'server_utils', '~> 0.1.0'
