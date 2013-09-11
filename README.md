# rs-base cookbook

Provides the basic recipes for setting up a RightScale instance.

# Requirements

Requires Chef 10

# Usage

Add a dependency to your cookbook's metadata.rb:

depends 'rs-base'

Add the recipe rs-base::setup_swap to your run list.

# Attributes

rs-base::setup_swap

default['rs-base']['swap']['size'] = 1024                     

The swap file size in M.  This attribute must be a numeric value.  The default is 
1024 or 1GB.

default['rs-base']['swap']['file'] = "/mnt/ephemeral/swapfile"

The location of the swap file.  This attribute must be a valid filename. By default 
this is on the ephemeral drive.  If no ephemeral drive exists then it will be created
on the root '/' parition.

# Recipes

rs-base::setup_swap

Creates a swapfile of the specified size 'default['rs-base']['swap']['size']' in the
specified location 'default['rs-base']['swap']['file']' and enables it's usage.
The swap file is added to /etc/fstab and will persist across reboots.  If the size or the
file location is invalid this recipe will fail with an error message indicating what the
failure was.

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)

Maintained by the RightScale White Team
