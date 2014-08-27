require 'spec_helper'

describe package('collectd') do
  it 'should be installed with version 4.10.X' do
    expect(subject.version).to be >= '4.10'
    expect(subject.version).to be < '5'
  end
end
