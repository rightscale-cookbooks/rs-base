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
  # RHEL 6.5 sets yum variable $releasever to 6Server.
  # This is a workaround since there is no epel repo of 6Server.
  if platform?('redhat') && node['platform_version'] =~ /^6/
    release_ver = '6'
  else
    release_ver = '$releasever'
  end

  yum_repository 'rightscale_software' do
    baseurl "http://mirror.rightscale.com/rightscale_software/epel/#{release_ver}/$basearch/"
    description 'RightScale Software'
    gpgkey 'http://mirror.rightscale.com/mirrorkeyring/rightscale_key.pub'
  end
end
