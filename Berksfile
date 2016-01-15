site :opscode

metadata

cookbook 'collectd', github: 'rightscale-cookbooks-contrib/chef-collectd', branch: 'generalize_install_for_both_centos_and_ubuntu'
cookbook 'rightscale_tag', github: 'cdwilhelm/rightscale_tag', branch: 'curt-dev'
cookbook 'machine_tag', github: 'cdwilhelm/machine_tag', branch: 'curt-dev'

group :integration do
  cookbook 'apt', '~> 2.9.2'
  cookbook 'yum-epel', '~> 0.4.0'
  cookbook 'fake', path: './test/cookbooks/fake'
  cookbook 'rhsm', '~> 1.0.0'
end
