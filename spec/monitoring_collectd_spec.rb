# frozen_string_literal: true
require_relative 'spec_helper'

describe 'rs-base::monitoring_collectd' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['rightscale']['instance_uuid'] = 'abcd1234'
      node.set['rs-base']['collectd_server'] = 'tss-4.rightscale.com'
      node.set['rightscale']['monitoring_collector_http'] = 'tss4.rightscale.com'
    end.converge(described_recipe)
  end

  file_content = <<-EOF
  RS_RLL_PORT=12345
  EOF

  context 'running the collectd install' do
    before(:each) do
      allow(::File).to receive(:exist?).and_call_original
      allow(::File).to receive(:exist?).with('/var/run/rightlink/secret').and_return true
      allow(::File).to receive(:exist?).with('/usr/local/bin/rsc').and_return true
      allow(::File).to receive(:read).and_call_original
      allow(::File).to receive(:read).with('/var/run/rightlink/secret').and_return file_content
    end

    it 'includes collectd default' do
      expect(chef_run).to include_recipe('collectd::default')
    end

    it 'updates the monitoring flag' do
      expect(chef_run).to run_bash('update rsc')
    end
  end
end
