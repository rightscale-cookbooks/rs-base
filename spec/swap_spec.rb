require_relative 'spec_helper'

describe 'rs-base::swap' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['rs-base']['swap']['file'] = '/mnt/ephemeral/swapfile'
    end.converge(described_recipe)
  end

  context 'rs-base default recipe run' do
    it 'will create swap directory' do
      expect(chef_run).to create_directory(
        ::File.dirname(chef_run.node['rs-base']['swap']['file'])).with(
          owner: 'root',
          group: 'root'
        )
    end

    it 'will create swap file' do
      expect(chef_run).to create_swap_file(chef_run.node['rs-base']['swap']['file'])
    end
  end
end
