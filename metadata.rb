name             'rs-base'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rs-base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.0'

supports "centos"
supports "ubuntu"

depends "ntp"

recipe "rs-base::setup_ntp", "Installs and configures ntp client."
