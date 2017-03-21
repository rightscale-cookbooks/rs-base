# frozen_string_literal: true
if node['rs-base']['sysctl']['enable']
  # https://wiki.mikejung.biz/Sysctl_tweaks
  include_recipe 'sysctl::default'
  node['rs-base']['sysctl']['settings'].each do |k, v|
    sysctl_param k do
      value v
    end
  end

  execute 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'
end
