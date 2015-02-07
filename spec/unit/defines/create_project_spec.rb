require 'spec_helper'

describe 'symfony::create_project', type: :define do
  let :pre_condition do
    "include symfony"
  end

  let(:title) { 'symfony/framework-standard-edition' }
  let(:params) { {target_dir: '/test/symfony'} }

  shared_examples 'create_project' do |params|

    p = {
      target_dir:    '/test/symfony',
      version:        nil,
      user:           nil,
      group:          nil,
      repository_url: nil,
      timeout:        600,
    }

    p.merge!(params) if params

    it do
      should contain_composer__project(title).with({
        project_name:   title,
        target_dir:     p[:target_dir],
        version:        p[:version],
        repository_url: p[:repository_url],
        user:           p[:user],
        timeout:        p[:timeout],
      })
    end
  end

  context 'for osfamily Debian' do
    let(:facts) {{ :osfamily => 'Debian' }}

    context 'defaults' do
      it_behaves_like 'create_project', {user:'www-data', group:'www-data'}
    end

    context 'all params' do
      title = 'sonata-project/sandbox'
      let(:title) { title }

      params = {
        project_name:   title,
        target_dir:     '/test/sonata-project',
        version:        'dev-2.4-develop',
        repository_url: 'https://github.com/sonata-project/sandbox.git',
        user:           'nobody',
        group:          'nobody',
        timeout:        300,
      }
      let(:params) { params }

      it_behaves_like 'create_project', params
    end

    context 'with parameters' do
      params = {
        target_dir: '/test/symfony',
        user: 'www-data',
        group: 'www-data',
        parameters: { 'foo' => 'bar'}
      }
      let(:params) { params }

      it_behaves_like 'create_project', params
      it do
        should contain_symfony__app__parameters('/test/symfony/app/config')
      end
    end
  end

  context 'for osfamily RedHat' do
    let(:facts) {{ :osfamily => 'RedHat' }}

    context 'defaults' do
      it_behaves_like 'create_project', {user:'apache', group:'apache'}
    end
  end
end
