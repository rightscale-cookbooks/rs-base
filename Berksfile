source 'https://supermarket.chef.io'
metadata

cookbook 'collectd'
cookbook 'marker', github: 'rightscale-cookbooks/marker'
cookbook 'rightscale_tag', github: 'rightscale-cookbooks/rightscale_tag'
cookbook 'machine_tag', github: 'rightscale-cookbooks/machine_tag'
cookbook 'ephemeral_lvm', github: 'rightscale-cookbooks/ephemeral_lvm'

group :integration do
  cookbook 'fake', path: './test/cookbooks/fake'
end
