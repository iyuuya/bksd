require 'rake/tasklib'
require 'pathname'

class AnyenvSetupTask < Rake::TaskLib
  def initialize(name)
    anyenv_tasks = ['anyenv:install', 'anyenv:install_plugins']
    @anyenv_home = Pathname.new(File.expand_path('~/.anyenv'))

    namespace :anyenv do
      desc 'install anyenv'
      task :install do
        if Dir.exist?(@anyenv_home)
          puts 'anyenv exist'
        else
          system "git clone https://github.com/riywo/anyenv #{@anyenv_home}"
        end
      end

      desc 'install anyenv plugins'
      task :install_plugins do
        path = @anyenv_home.join('plugins/anyenv-update')
        if Dir.exist?(path)
          puts 'anyenv-update exist'
        else
          system "git clone https://github.com/znz/anyenv-update #{path}"
        end
      end

      {
        rbenv: [
          { name: 'rbenv-default-gems', repository: 'https://github.com/rbenv/rbenv-default-gems' },
        ],
        pyenv: [
          { name: 'pyenv-default-packages', repository: 'https://github.com/jawshooah/pyenv-default-packages' },
          { name: 'pyenv-doctor', repository: 'https://github.com/yyuu/pyenv-doctor' },
          { name: 'pyenv-update', repository: 'https://github.com/yyuu/pyenv-update' },
          { name: 'pyenv-which-ext', repository: 'https://github.com/yyuu/pyenv-which-ext' },
          { name: 'pyenv-pip-rehash', repository: 'https://github.com/yyuu/pyenv-pip-rehash' },
          { name: 'pyenv-virtualenv', repository: 'https://github.com/yyuu/pyenv-virtualenv' },
        ],
        ndenv: [
          { name: 'ndenv-default-npms', repository: 'https://github.com/kaave/ndenv-default-npms' },
        ],
        phpenv: [
          { name: 'phpenv-composer', repository: 'https://github.com/ngyuki/phpenv-composer' },
        ],
        goenv: [
        ],
      }.each do |xxenv, plugins|
        task_name = define_install_xxenv(xxenv)
        anyenv_tasks << "anyenv:#{task_name}"

        plugins.each do |plugin|
          task_name = define_install_xxenv_plugin(xxenv, plugin[:name], plugin[:repository])
          anyenv_tasks << "anyenv:#{task_name}"
        end
      end
    end

    task name => anyenv_tasks
  end

  private

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
    task_name
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
    task_name
  end
end
