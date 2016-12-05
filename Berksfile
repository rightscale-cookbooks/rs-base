source "https://supermarket.chef.io"
metadata

cookbook 'collectd'
cookbook 'rightscale_tag', github: 'rightscale-cookbooks/rightscale_tag'
cookbook 'machine_tag', github: 'rightscale-cookbooks/machine_tag'

group :integration do
  cookbook 'fake', path: './test/cookbooks/fake'
end
