# frozen_string_literal: true
name             'fake'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures a test tools'
version          '0.1.0'

recipe 'fake::rightscale_software', 'Installs the rightscale_software and rightscale_software_ubuntu repositories'
recipe 'fake::tcpdump', 'Installs tcpdump'
recipe 'fake::create_secrets', 'creates secrets file'
