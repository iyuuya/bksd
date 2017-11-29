require 'rake/tasklib'

class AnyenvSetupTask < Rake::TaskLib
  def initialize(name)
    task name => ['anyenv:install', 'anyenv:install_plugins', 'anyenv:install_rbenv', 'anyenv:install_rbenv_plugins']

    namespace :anyenv do
      desc 'install anyenv'
      task :install do
        if Dir.exist?(File.expand_path('~/.anyenv'))
          puts 'anyenv exist'
        else
          system 'git clone https://github.com/riywo/anyenv ~/.anyenv'
        end
      end

      desc 'install anyenv plugins'
      task :install_plugins do
        if Dir.exist?(File.expand_path('~/.anyenv/plugins/anyenv-update'))
          puts 'anyenv-update exist'
        else
          system 'git clone https://github.com/znz/anyenv-update ~/.anyenv/plugins/anyenv-update'
        end
      end

      desc 'install rbenv on anyenv'
      task :install_rbenv do
        if Dir.exist?(File.expand_path('~/.anyenv/envs/rbenv'))
          puts 'rbenv exist'
        else
          system({ 'PATH' => '~/.anyenv/bin:$PATH' }, 'eval "$(anyenv init -)" && anyenv install rbenv')
        end
      end

      desc 'install rbenv plugins'
      task :install_rbenv_plugins do
        if Dir.exist?(File.expand_path('~/.anyenv/envs/rbenv/plugins/rbenv-default-gems'))
          puts 'rbenv-default-gems exist'
        else
          system 'git clone https://github.com/rbenv/rbenv-default-gems ~/.anyenv/envs/rbenv/plugins/rbenv-default-gems'
        end
      end

      # TODO:
      # pyenv, pyenv-default-packages, pyenv-doctor, pyenv-update, pyenv-which-ext, pyenv-pip-rehash, pyenv-virtualenv
      # ndenv, ndenv-default-npms
      # phpenv, phpenv-composer
      # goenv
      task :install_pyenv
      task :install_pyenv_plugins
      task :install_ndenv
      task :install_ndenv_plugins
      task :install_phpenv
      task :install_phpenv_plugins
      task :install_goenv
    end
  end
end
