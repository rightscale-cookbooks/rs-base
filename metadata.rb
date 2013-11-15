name             'rs-base'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rs-base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports "centos"
supports "ubuntu"

depends "ntp", "~> 1.4.0"
depends "marker", "~> 1.0.0"
depends "swap", "~> 0.3.5"
depends "rsyslog", "~> 1.8.0"

recipe "rs-base::default", "All-in-one recipe to run all recipes in rs-base cookbook."
recipe "rs-base::ntp", "Installs and configures ntp client."
recipe "rs-base::swap", "Create and setup a swap file."
recipe "rs-base::rsyslog", "Install and setup rsyslog."

attribute "rs-base/ntp/servers",
  :display_name => "NTP Servers",
  :description =>
    "A comma-separated list of fully qualified domain names" +
    " for the array of servers that instances should talk to." +
    " Example: time1.example.com, time2.example.com, time3.example.com",
  :type => "array",
  :default => [
    "time.rightscale.com",
    "ec2-us-east.time.rightscale.com",
    "ec2-us-west.time.rightscale.com"
  ]

attribute "rs-base/rsyslog_server",
  :display_name => "Remote Rsyslog Server",
  :description =>
    "The FQDN or IP address of the remote rsyslog server.  If blank no remote syslog server is setup.",
  :recipes => ["rs-base::rsyslog"],
  :required => "optional"
