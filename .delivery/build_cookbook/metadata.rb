name 'build_cookbook'
maintainer 'Ed Overton'
maintainer_email 'e.overton@gmail.com'
license 'all_rights'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'delivery-truck'
