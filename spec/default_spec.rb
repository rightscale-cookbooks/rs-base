# frozen_string_literal: true
require_relative 'spec_helper'

describe 'rs-base::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['rightscale']['instance_uuid'] = 'abcd1234'
      node.set['rs-base']['collectd_server'] = 'tss-4.rightscale.com'
    end.converge(described_recipe)
  end

  file_content = <<-EOF
  RS_RLL_PORT=12345
  EOF

  context 'rs-base default recipe run' do
    before(:each) do
      allow(::File).to receive(:exist?).and_call_original
      allow(::File).to receive(:exist?).with('/var/run/rightlink/secret').and_return true
      allow(::File).to receive(:read).and_call_original
      allow(::File).to receive(:read).with('/var/run/rightlink/secret').and_return file_content
    end

    it 'includes the rightscale_tag::default recipe' do
      expect(chef_run).to include_recipe('rightscale_tag::default')
    end

    it 'includes the swap recipe' do
      expect(chef_run).to include_recipe('rs-base::swap')
    end

    it 'includes the ntp recipe' do
      expect(chef_run).to include_recipe('rs-base::ntp')
    end

    it 'includes the rsyslog recipe' do
      expect(chef_run).to include_recipe('rs-base::rsyslog')
    end

    it 'includes the collectd recipe' do
      chef_run.node.set['rs-base']['monitoring_type'] = 'collectd'
      expect(chef_run).to include_recipe('rs-base::monitoring_collectd')
    end
  end

  context 'rs-base default with rightlink monitoring' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['rs-base']['monitoring_type'] = 'rightlink'
        node.set['rightscale']['instance_uuid'] = 'abcd1234'
        node.set['rs-base']['collectd_server'] = 'tss-4.rightscale.com'
      end.converge(described_recipe)
    end

    before(:each) do
      allow(::File).to receive(:exist?).and_call_original
      allow(::File).to receive(:exist?).with('/var/run/rightlink/secret').and_return true
      allow(::File).to receive(:read).and_call_original
      allow(::File).to receive(:read).with('/var/run/rightlink/secret').and_return file_content
    end

    it 'should run rightlink monitoring' do
      expect(chef_run).to include_recipe('rs-base::monitoring_rightlink')
    end
  end
end
