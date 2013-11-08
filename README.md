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

<table>
  <tr>
    <th>Key</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td nowrap><tt>['rs-base']['swap']['size']</tt></td>
    <td>The swap file size in MB.  This attribute must be a numeric value.</td>
    <td><tt>1024</tt></td>
  </tr>
  <tr>
    <td nowrap><tt>['rs-base']['swap']['file']</tt></td>
    <td>The location of the swap file.  This attribute must be a valid filename.  By default
        this is on the ephemeral drive.  If no ephemeral drive exists then it will be created
        on the root '/' partition.</td>
    <td><tt>/mnt/ephemeral/swapfile</tt></td>
  </tr>
  <tr>
    <td nowrap><tt>['rs-base']['ntp']['servers']</tt></td>
    <td>List of fully qualified domain names for the array of servers that are used for updating time.</td>
    <td><tt>time.rightscale.com, ec2-us-east.time.rightscale.com, ec2-us-west.time.rightscale.com</tt></td>
  </tr>
</table>

# Recipes

`rs-base::swap`

Creates a swapfile of the specified size 'default['rs-base']['swap']['size']' in the
specified location 'default['rs-base']['swap']['file']' and enables it's usage.
The swap file is added to /etc/fstab and will persist across reboots.  If the size or the
file location is invalid this recipe will fail with an error message indicating what the
failure was.

`rs-base::ntp`

Configures ntp using servers in ['rs-base']['ntp']['servers'].

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)
