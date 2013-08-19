name             'rs-base'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rs-base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.1.0'

supports "centos"
supports "ubuntu"

depends "ntp"

recipe "rs-base::setup_ntp", "Installs and configures ntp client."

attribute "rs-base/ntp/servers",
  :display_name => "NTP Servers",
  :description =>
    "A comma-separated list of fully qualified domain names " +
    " for the array of servers that instances should talk to. " +
    " Example: time1.example.com, time2.example.com, time3.example.com",
  :type => "string",
  :default => "time.rightscale.com, ec2-us-east.time.rightscale.com, " +
    "ec2-us-west.time.rightscale.com"

