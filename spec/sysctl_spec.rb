# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'rs-base::sysctl' do
  platforms?.each do |platform, versions|
    versions.each do |version|
      context "sysctl tuning is enabled on #{platform.capitalize} #{version}" do
        cached(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version) do |node|
            node.set['rs-base']['sysctl']['enabled'] = true
          end.converge(described_recipe)
        end

        it 'sets the following sysctl settings' do
          chef_run.node['rs-base']['sysctl']['settings'].each do |k, v|
            pp "setting sysctl param(#{k}) with value(#{v})"
            expect(chef_run).to apply_sysctl_param(k).with(value: v)
          end
        end
        it 'sets \'echo never > /sys/kernel/mm/transparent_hugepage/enabled\'' do
          expect(chef_run).to run_execute('echo never > /sys/kernel/mm/transparent_hugepage/enabled')
        end
      end
    end
  end
end
