# frozen_string_literal: true
#
# Cookbook Name:: fake
# Recipe:: rightscale_software
#
# Copyright (C) 2014 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if platform_family?('debian')
  apt_repository 'rightscale_software_ubuntu' do
    uri 'http://mirror.rightscale.com/rightscale_software_ubuntu/latest'
    distribution node['lsb']['codename']
    components ['main']
    key 'http://mirror.rightscale.com/mirrorkeyring/rightscale_key.pub'
  end
elsif platform_family?('rhel')
  # RHEL 6.5 and 7.0 sets yum variable $releasever to 6Server and 7Server.
  # This is a workaround since there is no epel repo for 6Server or 7Server.
  release_ver = if platform?('redhat') && node['platform_version'] =~ /^6/
                  '6'
                elsif platform?('redhat') && node['platform_version'] =~ /^7/
                  '7'
                else
                  '$releasever'
                end

  yum_repository 'rightscale_software' do
    baseurl "http://mirror.rightscale.com/rightscale_software/epel/#{release_ver}/$basearch/"
    description 'RightScale Software'
    gpgkey 'http://mirror.rightscale.com/mirrorkeyring/rightscale_key.pub'
  end
end
