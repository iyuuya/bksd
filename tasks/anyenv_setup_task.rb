require 'rake/tasklib'

class AnyenvSetupTask < Rake::TaskLib
  def initialize(name)
    task name => [
      'anyenv:install',
      'anyenv:install_plugins',
      'anyenv:install_rbenv',
      'anyenv:install_pyenv',
      'anyenv:install_ndenv',
      'anyenv:install_phpenv',
      'anyenv:install_goenv',
      'anyenv:install_rbenv_plugins'
    ]

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

      define_install_xxenv(:rbenv)
      define_install_xxenv(:pyenv)
      define_install_xxenv(:ndenv)
      define_install_xxenv(:phpenv)
      define_install_xxenv(:goenv)

      desc 'install rbenv plugins'
      task :install_rbenv_plugins do
        if Dir.exist?(File.expand_path('~/.anyenv/envs/rbenv/plugins/rbenv-default-gems'))
          puts 'rbenv-default-gems exist'
        else
          system 'git clone https://github.com/rbenv/rbenv-default-gems ~/.anyenv/envs/rbenv/plugins/rbenv-default-gems'
        end
      end

      # TODO:
      #   pyenv-default-packages, pyenv-doctor, pyenv-update, pyenv-which-ext, pyenv-pip-rehash, pyenv-virtualenv
      #   ndenv-default-npms
      #   phpenv-composer
      task :install_pyenv_plugins
      task :install_ndenv_plugins
      task :install_phpenv_plugins
    end
  end

  private

  def define_install_xxenv(xxenv)
    desc "install #{xxenv} on anyenv"
    task "install_#{xxenv}" do
      if Dir.exist?(File.expand_path("~/.anyenv/envs/#{xxenv}"))
        puts "#{xxenv} exist"
      else
        system "PATH=~/.anyenv/bin:$PATH eval \"$(anyenv init - --no-rehash)\"; anyenv install #{xxenv}"
      end
    end
  end
end
