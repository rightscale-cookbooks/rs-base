# frozen_string_literal: true
name             'rs-base'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache-2.0'
description      'Installs/Configures rs-base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.1.3'
issues_url       'https://github.com/rightscale-cookbooks/rs-base/issues' if respond_to?(:issues_url)
source_url       'https://github.com/rightscale-cookbooks/rs-base' if respond_to?(:source_url)
chef_version     '>= 12.0' if respond_to?(:chef_version)

supports 'centos'
supports 'ubuntu'

depends 'apt'
depends 'yum-epel'
depends 'ntp'
depends 'rightscale_tag', '~> 2.0'
depends 'machine_tag', '~> 2.0'
depends 'swap', '>= 2.0'
depends 'rsyslog'
depends 'collectd', '>= 2.2'
depends 'collectd_plugins', '>= 2.1'
depends 'ephemeral_lvm', '>= 3.0'
depends 'selinux_policy'
depends 'sysctl'

recipe 'rs-base::default', 'All-in-one recipe to run all recipes in rs-base cookbook.'
recipe 'rs-base::ntp', 'Installs and configures ntp client.'
recipe 'rs-base::swap', 'Create and setup a swap file.'
recipe 'rs-base::rsyslog', 'Install and setup rsyslog.'
recipe 'rs-base::monitoring_collectd', 'Install and setup collectd and basic set of plugins'
recipe 'rs-base::monitoring_rightlink', 'Configures rightlink default monitoring'
recipe 'rs-base::sysctl', 'installs kernel tuning'
