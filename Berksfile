site :opscode

metadata

cookbook 'rightscale_tag', github: 'rightscale-cookbooks/rightscale_tag', ref: 'b487656521e4bf2a58a10856f29fcad35340b9bf'
cookbook 'collectd', github: 'EfrainOlivares/chef-collectd', branch: 'generalize_install_for_both_centos_and_ubuntu'

group :integration do
  cookbook 'apt', '~> 2.3.0'
  cookbook 'yum', '~> 2.4.4'
end
