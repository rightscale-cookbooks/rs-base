# rs-base cookbook

[![Release](https://img.shields.io/github/release/rightscale-cookbooks/rs-base.svg?style=flat)][release]
[![Build Status](https://img.shields.io/travis/rightscale-cookbooks/rs-base.svg?style=flat)][travis]

[release]: https://github.com/rightscale-cookbooks/rs-base/releases/latest
[travis]: https://travis-ci.org/rightscale-cookbooks/rs-base

Provides the basic recipes for setting up a RightScale instance.

Github Repository: [https://github.com/rightscale-cookbooks/rs-base](https://github.com/rightscale-cookbooks/rs-base)

# Requirements

* Requires Chef 12 or higher
* Requires [RightLink 10](http://docs.rightscale.com/rl10/) See cookbook version 1.1.7 for RightLink 6 support
* Cookbook requirements
  * [ntp](https://supermarket.chef.io/cookbooks/ntp)
  * [marker](http://supermarket.chef.io/cookbooks/marker)
  * [rightscale_tag](http://supermarket.chef.io/cookbooks/rightscale_tag)
  * [swap](http://supermarket.chef.io/cookbooks/swap)
  * [rsyslog](http://supermarket.chef.io/cookbooks/rsyslog)
  * [collectd](https://supermarket.chef.io/cookbooks/collectd)
  * [sysctl](https://supermarket.chef.io/cookbooks/sysctl)
  * [selinux_policy](https://supermarket.chef.io/cookbooks/selinux_policy)
  * [ephemeral_lvm](https://supermarket.chef.io/cookbooks/ephemeral_lvm)
* Platform
  * Ubuntu 14.04
  * Ubuntu 16.04
  * CentOS 6
  * CentOS 7

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
* `node['rs-base']['sysctl']['settings']` - see `attributes\sysctl.rb` for defaults

# Recipes

## rs-base::default

All-in-one recipe to run all recipes in rs-base cookbook.

## rs-base::swap

Creates a swapfile of the specified size (in GB) `node['rs-base']['swap']['size']` in the
specified location `node['rs-base']['swap']['file']` and enables its usage.
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

## rs-base::sysctl

Set's the sysctl parameters based off netflix tuning page: https://wiki.mikejung.biz/Sysctl_tweaks#Netflix_2014_EC2_sysctl_tweaks(https://wiki.mikejung.biz/Sysctl_tweaks#Netflix_2014_EC2_sysctl_tweaks)

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)
