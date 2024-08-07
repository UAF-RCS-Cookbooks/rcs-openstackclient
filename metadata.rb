name              'rcs-openstackclient'
maintainer        'OpenStack'
maintainer_email  'openstack-discuss@lists.openstack.org'
license           'Apache-2.0'
description       'Installs the fog-openstack gem and offers LWRPs to use it'
issues_url        'https://launchpad.net/openstack-chef'
source_url        'https://opendev.org/openstack/cookbook-openstack-client'
chef_version      '>= 16.0'
version           '20.0.0'

%w(ubuntu redhat centos).each do |os|
  supports os
end

gem 'fog-openstack', '~> 1.0.11'
