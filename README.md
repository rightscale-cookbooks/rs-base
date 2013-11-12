# rs-base cookbook

[![Build Status](https://travis-ci.org/rightscale-cookbooks/rs-base.png?branch=master)](https://travis-ci.org/rightscale-cookbooks/rs-base)

Provides the basic recipes for setting up a RightScale instance.

# Requirements

Requires Chef 10

# Usage

Add a dependency to your cookbook's `metadata.rb`:

```ruby
depends 'rs-base'
```

Add the provided recipes in this cookbook to your run list as needed.

# Attributes

| Key | Description | Default | Examples |
| --- | --- | --- | --- |
| ['rs-base']['swap']['size']  | The swap file size in MB.  This attribute must be a numeric value. | 1024 | 512, 2048 |
| ['rs-base']['swap']['file']  | The location of the swap file.  This attribute must be a valid filename.  By default this is on the ephemeral drive.  If no ephemeral drive exists then it will be created on the root '/' partition. | /mnt/ephemeral/swapfile | /tmp/swap_file, /swap |
| ['rs-base']['ntp']['servers'] | List of fully qualified domain names for the array of servers that are used for updating time. | time.rightscale.com, ec2-us-east.time.rightscale.com, ec2-us-west.time.rightscale.com | 0.pool.ntp.org, 1.pool.ntp.org |

# Recipes

`rs-base::default`

All-in-one recipe to run all recipes in rs-base cookbook.

`rs-base::swap`

Creates a swapfile of the specified size '['rs-base']['swap']['size']' in the
specified location '['rs-base']['swap']['file']' and enables it's usage.
The swap file is added to /etc/fstab and will persist across reboots.  If the size or the
file location is invalid this recipe will fail with an error message indicating what the
failure was.

`rs-base::ntp`

Configures ntp using servers in ['rs-base']['ntp']['servers'].

`rs-base::syslog`

Install and setup rsyslog.

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)
