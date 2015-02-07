require 'spec_helper'

describe 'symfony::params', :type => :class do

  context 'for osfamily RedHat' do
    let(:facts) {{ :osfamily => 'RedHat' }}

    it { should contain_class('symfony::params') }
  end

  context 'for osfamily Debian' do
    let(:facts) {{ :osfamily => 'Debian' }}

    it { should contain_class('symfony::params') }
  end

  context 'for osfamily Debian' do
    let(:facts) {{ :osfamily => 'Debian' }}

    it { should contain_class('symfony::params') }
  end

  context 'for osfamily Darwin' do
    let(:facts) {{ :osfamily => 'Darwin' }}

    it { should contain_class('symfony::params') }
  end

  context 'unsupported osfamily' do
    let :facts do
      {
	:osfamily        => 'Windows',
	:operatingsystem => 'Windows',
      }
    end

    it 'should fail' do
      expect { should contain_class('symfony::params') }.
	to raise_error(Puppet::Error, /Unsupported platform: Windows/)
    end
  end

end
