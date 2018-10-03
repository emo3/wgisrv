#
# Cookbook:: wgisrv
# Spec:: default
#
# Copyright:: 2018, Ed Overton, All Rights Reserved.

require 'spec_helper'

describe 'wgisrv::make_nc_wg' do
  context 'When all attributes are default, on 7.4.1708' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
