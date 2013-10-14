name             'rs-base'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rs-base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.1.0'

supports "centos"
supports "ubuntu"

depends "ntp", "~> 1.4.0"
depends "marker", "~> 0.1.0"
depends "swap", "~> 0.3.5"
depends "rsyslog", "~> 1.8.0"
depends "ephemeral_lvm", "~> 0.1.0"

recipe "rs-base::ntp", "Installs and configures ntp client."

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
  :recipes => ["rs-base::syslog"],
  :required => "optional"

attribute "ephemeral_lvm/filesystem",
  :display_name => "Ephemeral LVM Filesystem",
  :description => "The filesystem to be used on the ephemeral volume",
  :default => "ext4",
  :recipes => ["rs-base::default"],
  :required => "recommended"

attribute "ephemeral_lvm/mount_point",
  :display_name => "Ephemeral LVM Mount Point",
  :description => "The mount point for the ephemeral volume",
  :default => "/mnt/ephemeral",
  :recipes => ["rs-base::default"],
  :required => "recommended"

attribute "ephemeral_lvm/volume_group_name",
  :display_name => "Ephemeral LVM Volume Group Name",
  :description => "The volume group name for the ephemeral LVM",
  :default => "vg-data",
  :recipes => ["rs-base::default"],
  :required => "optional"

attribute "ephemeral_lvm/logical_volume_size",
  :display_name => "Ephemeral LVM Logical Volume Size",
  :description => "The size to be used for the ephemeral LVM",
  :default => "100%VG",
  :recipes => ["rs-base::default"],
  :required => "optional"

attribute "ephemeral_lvm/logical_volume_name",
  :display_name => "Ephemeral LVM Logical Volume Name",
  :description => "The name of the logical volume for ephemeral LVM",
  :default => "ephemeral0",
  :recipes => ["rs-base::default"],
  :required => "optional"

attribute "ephemeral_lvm/stripe_size",
  :display_name => "Ephemeral LVM Stripe Size",
  :description => "The stripe size to be used for the ephemeral logical volume",
  :default => "512",
  :recipes => ["rs-base::default"],
  :required => "optional"
