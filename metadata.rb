name             'rs-base'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rs-base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.3'

supports "centos"
supports "ubuntu"

depends 'apt', '~> 2.5.3'
depends "ntp", "~> 1.4.0"
depends 'marker', '~> 1.0.1'
depends 'rightscale_tag', '~> 1.0.3'
depends "swap", "~> 0.3.5"
depends "rsyslog", "~> 1.12.2"
depends "collectd", "~> 1.1.0"

recipe "rs-base::default", "All-in-one recipe to run all recipes in rs-base cookbook."
recipe "rs-base::ntp", "Installs and configures ntp client."
recipe "rs-base::swap", "Create and setup a swap file."
recipe "rs-base::rsyslog", "Install and setup rsyslog."
recipe "rs-base::collectd", "Install and setup collectd and basic set of plugins"

attribute "rs-base/ntp/servers",
  :display_name => "NTP Servers",
  :description =>
    "A comma-separated list of fully qualified domain names" +
    " for the array of servers that instances should talk to." +
    " Example: time1.example.com, time2.example.com, time3.example.com",
  :recipes => ["rs-base::default", "rs-base::ntp"],
  :required => "optional",
  :type => "array",
  :default => [
    "time.rightscale.com",
    "ec2-us-east.time.rightscale.com",
    "ec2-us-west.time.rightscale.com"
  ]

attribute "rs-base/swap/size",
  :display_name => "Swap Size",
  :description =>
    "The size of the swap file (in Gigabytes). This value should be an integer." +
    " Example: 1",
  :recipes => ["rs-base::default", "rs-base::swap"],
  :required => "optional",
  :default => "1"

attribute "rs-base/rsyslog_server",
  :display_name => "Remote rsyslog Server",
  :description =>
    "The FQDN or IP address of the remote rsyslog server.  If blank no remote syslog server is setup.",
  :recipes => ["rs-base::default", "rs-base::rsyslog"],
  :required => "optional"

# This input is required for setting up monitoring and should be set at the ServerTemplate level
attribute "rs-base/collectd_server",
  :display_name => "Remote collectd Server",
  :description =>
    "The FQDN or IP address of the remote collectd server.",
  :recipes => ["rs-base::default", "rs-base::collectd"],
  :required => "optional"
