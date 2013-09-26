# rs-base cookbook

Provides the basic recipes for setting up a RightScale instance.

# Requirements

Requires Chef 10

# Usage

Add a dependency to your cookbook's metadata.rb:

depends 'rs-base'

Add the recipe rs-base::swap to your run list.

# Attributes

rs-base::swap

default['rs-base']['swap']['size'] = 1024 # MB

The swap file size in MB.  This attribute must be a numeric value.  The default is
1024 or 1GB.

default['rs-base']['swap']['file'] = "/mnt/ephemeral/swapfile"

The location of the swap file.  This attribute must be a valid filename. By default
this is on the ephemeral drive.  If no ephemeral drive exists then it will be created
on the root '/' parition.

#### rs-base::ntp
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td nowrap><tt>['rs-base']['ntp']['servers']</tt></td>
    <td>Array</td>
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
