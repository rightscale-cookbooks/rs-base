# rs-base cookbook

[![Build Status](https://travis-ci.org/rightscale-cookbooks/rs-base.png?branch=master)](https://travis-ci.org/rightscale-cookbooks/rs-base)

Provides the basic recipes for setting up a RightScale instance.

Github Repository: [https://github.com/rightscale-cookbooks/rs-base](https://github.com/rightscale-cookbooks/rs-base)

# Requirements

* Requires Chef 11 or higher
* Cookbook requirements
  * [ntp](http://community.opscode.com/cookbooks/ntp)
  * [marker](http://community.opscode.com/cookbooks/marker)
  * [rightscale_tag](http://community.opscode.com/cookbooks/rightscale_tag)
  * [swap](http://community.opscode.com/cookbooks/swap)
  * [rsyslog](http://community.opscode.com/cookbooks/rsyslog)
  * [collectd](https://github.com/EfrainOlivares/chef-collectd)
* Platform
  * Ubuntu 12.04
  * CentOS 6

# Usage

Place the `rs-base::default` recipe in the runlist.

# Attributes

* `node['rs-base']['swap']['size']` - The swap file size in GB. This attribute must be an integer.
  Default is `1`.
* `node['rs-base']['swap']['file']` - The location of the swap file. This attribute must be a valid filename.
  Default is `'/mnt/ephemeral/swapfile'`.
* `node['rs-base']['ntp']['servers']` - List of fully qualified domain names for the array of servers that are used for
  updating time.
  Default is `['time.rightscale.com', 'ec2-us-east.time.rightscale.com', 'ec2-us-west.time.rightscale.com']`.
* `node['rs-base']['rsyslog_server']` - FQDN or IP address of a remote rsyslog server. Default is `nil`.

# Recipes

## rs-base::default

All-in-one recipe to run all recipes in rs-base cookbook.

## rs-base::swap

Creates a swapfile of the specified size (in GB) `node['rs-base']['swap']['size']` in the
specified location `node['rs-base']['swap']['file']` and enables it's usage.
The swap file is added to `/etc/fstab` and will persist across reboots. If the size or the
file location is invalid this recipe will fail with an error message indicating what the
failure was.

## rs-base::ntp

Configures ntp using servers in `node['rs-base']['ntp']['servers']`.

## rs-base::rsyslog

Installs and configures the rsyslog service. If `node['rs-base']['rsyslog_server']` is set, its value will be
used as the remote syslog server. Otherwise local machine is used.

## rs-base::collectd

Installs the collectd client with some of the basic plugins, syslog, interface, df, disk, memory, load,
processes, users, and network.

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)
