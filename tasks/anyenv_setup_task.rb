require 'rake/tasklib'
require 'pathname'

class AnyenvSetupTask < Rake::TaskLib
  def initialize(name)
    @name = name
    @anyenv_tasks = []
    @anyenv_home = Pathname.new(File.expand_path('~/.anyenv'))

    define
  end

  private

  def define
    namespace :anyenv do
      define_install_anyenv
      define_install_anyenv_plugins

      {
        rbenv: [
          { name: 'rbenv-default-gems', repository: 'https://github.com/rbenv/rbenv-default-gems' }
        ],
        pyenv: [
          { name: 'pyenv-default-packages', repository: 'https://github.com/jawshooah/pyenv-default-packages' },
          { name: 'pyenv-doctor', repository: 'https://github.com/yyuu/pyenv-doctor' },
          { name: 'pyenv-update', repository: 'https://github.com/yyuu/pyenv-update' },
          { name: 'pyenv-which-ext', repository: 'https://github.com/yyuu/pyenv-which-ext' },
          { name: 'pyenv-pip-rehash', repository: 'https://github.com/yyuu/pyenv-pip-rehash' },
          { name: 'pyenv-virtualenv', repository: 'https://github.com/yyuu/pyenv-virtualenv' }
        ],
        ndenv: [
          { name: 'ndenv-default-npms', repository: 'https://github.com/kaave/ndenv-default-npms' }
        ],
        phpenv: [
          { name: 'phpenv-composer', repository: 'https://github.com/ngyuki/phpenv-composer' }
        ],
        goenv: []
      }.each do |xxenv, plugins|
        define_install_xxenv(xxenv)
        plugins.each do |plugin|
          define_install_xxenv_plugin(xxenv, plugin[:name], plugin[:repository])
        end
      end
    end

    task @name => @anyenv_tasks
  end

  def define_install_anyenv
    desc 'install anyenv'
    task :install do
      if Dir.exist?(@anyenv_home)
        puts 'anyenv exist'
      else
        system "git clone https://github.com/riywo/anyenv #{@anyenv_home}"
      end
    end
    @anyenv_tasks << 'anyenv:install'
  end

  def define_install_anyenv_plugins
    desc 'install anyenv plugins'
    task :install_plugins do
      path = @anyenv_home.join('plugins/anyenv-update')
      if Dir.exist?(path)
        puts 'anyenv-update exist'
      else
        system "git clone https://github.com/znz/anyenv-update #{path}"
      end
    end
    @anyenv_tasks << 'anyenv:install_plugins'
  end

  def define_install_xxenv(xxenv)
    task_name = "install_#{xxenv}"
    desc "install #{xxenv} on anyenv"
    task task_name do
      path = @anyenv_home.join("envs/#{xxenv}")
      if Dir.exist?(path)
        puts "#{xxenv} exist"
      else
        system "PATH=~/.anyenv/bin:$PATH eval \"$(anyenv init - --no-rehash)\"; anyenv install #{xxenv}"
      end
    end
    @anyenv_tasks << "anyenv:#{task_name}"
  end

  def define_install_xxenv_plugin(xxenv, name, repository)
    task_name = "install_#{xxenv}_plugin_#{name}"
    desc "install #{name} (#{xxenv} plugin)"
    task task_name do
      path = @anyenv_home.join("envs/#{xxenv}/plugins/#{name}")
      if Dir.exist?(path)
        puts "#{name} exist"
      else
        system "git clone #{repository} #{path}"
      end
    end
    @anyenv_tasks << "anyenv:#{task_name}"
  end
end
