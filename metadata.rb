name 'wgisrv'
maintainer 'Ed Overton'
maintainer_email 'bogus@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures wgisrv'
long_description 'Installs/Configures wgisrv'
version '1.1.0'
chef_version '>= 13.0'
supports 'redhat'
supports 'centos'

issues_url 'https://github.com/emo3/wgisrv/issues' if respond_to?(:issues_url)
source_url 'https://github.com/emo3/wgisrv'

depends 'nc_base'
depends 'server_utils'
