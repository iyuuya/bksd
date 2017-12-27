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
          { name: 'rbenv-default-gems', repository: 'rbenv/rbenv-default-gems' },
          { name: 'rbenv-each', repository: 'rbenv/rbenv-each' }
        ],
        pyenv: [
          { name: 'pyenv-default-packages', repository: 'jawshooah/pyenv-default-packages' },
          { name: 'pyenv-doctor', repository: 'yyuu/pyenv-doctor' },
          { name: 'pyenv-update', repository: 'yyuu/pyenv-update' },
          { name: 'pyenv-which-ext', repository: 'yyuu/pyenv-which-ext' },
          { name: 'pyenv-pip-rehash', repository: 'yyuu/pyenv-pip-rehash' },
          { name: 'pyenv-virtualenv', repository: 'yyuu/pyenv-virtualenv' }
        ],
        ndenv: [
          { name: 'ndenv-default-npms', repository: 'kaave/ndenv-default-npms' }
        ],
        phpenv: [
          { name: 'phpenv-composer', repository: 'ngyuki/phpenv-composer' }
        ],
        goenv: []
      }.each do |xxenv, plugins|
        define_install_xxenv(xxenv)
        plugin_tasks = plugins.map do |plugin|
          define_install_xxenv_plugin(xxenv, plugin[:name], plugin[:repository])
        end
        desc "install #{xxenv} plugins"
        task "install_#{xxenv}_plugins" => plugin_tasks
      end
    end

    task @name => @anyenv_tasks
  end

  def define_install_anyenv
    desc 'install anyenv'
    task :install do
      github 'riywo/anyenv', @anyenv_home
    end
    @anyenv_tasks << 'anyenv:install'
  end

  def define_install_anyenv_plugins
    desc 'install anyenv plugins'
    task :install_plugins do
      github 'znz/anyenv-update', @anyenv_home.join('plugins/anyenv-update')
    end
    @anyenv_tasks << 'anyenv:install_plugins'
  end

  def define_install_xxenv(xxenv)
    task_name = "install_#{xxenv}"
    desc "install #{xxenv} on anyenv"
    task task_name do
      if @anyenv_home.join("envs/#{xxenv}").exist?
        puts "#{xxenv} exist"
      else
        system "PATH=~/.anyenv/bin:$PATH eval \"$(anyenv init - --no-rehash)\"; anyenv install #{xxenv}"
      end
    end
    @anyenv_tasks << "anyenv:#{task_name}"
    task_name
  end

  def define_install_xxenv_plugin(xxenv, name, repository)
    task_name = "install_#{xxenv}_plugin_#{name}"
    desc "install #{name} (#{xxenv} plugin)"
    task task_name do
      github repository, @anyenv_home.join("envs/#{xxenv}/plugins/#{name}")
    end
    @anyenv_tasks << "anyenv:#{task_name}"
    task_name
  end

  def github(repo, path, check = true)
    if check && path.exist?
      puts "#{repo} exist"
      return
    end
    system "git clone https://github.com/#{repo} #{path}"
  end
end
