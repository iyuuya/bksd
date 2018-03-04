require 'fileutils'
require_relative 'tasks/dot_install_task'
require_relative 'tasks/homebrew_setup_task'
require_relative 'tasks/anyenv_setup_task'

namespace :bksd do
  desc 'make ~/bin'
  task :bin_mkdir do
    path = File.expand_path('~/bin')
    FileUtils.mkdir(path) unless Dir.exist?(path)
  end

  desc 'bin symbolick links(force)'
  task bin_link: :bin_mkdir do
    Dir["#{__dir__}/bin/*"].each do |filename|
      FileUtils.ln_s filename, File.expand_path("~/bin/#{File.basename(filename)}"), force: true
    end
  end
end

DotInstallTask.new :ssh
DotInstallTask.new :git
DotInstallTask.new :vim do |t|
  volt_path = ENV.fetch('VOLTPATH', File.expand_path('~/volt'))
  FileUtils.mkdir(volt_path) unless Dir.exist?(volt_path)

  t.add_link 'volt/lock.json', 'volt/lock.json'
  t.add_link 'volt/plugconf', 'volt/plugconf'
  t.add_link 'volt/rc', 'volt/rc'
  t.add_link 'bin/mvim', 'bin/mvim' if /darwin/ =~ RUBY_PLATFORM
end
DotInstallTask.new :zsh
DotInstallTask.new :ruby do |t|
  t.add_link 'default-gems', 'default-gems', ENV['RBENV_ROOT'] || '~/.anyenv/envs/rbenv/'
end
DotInstallTask.new :tmux do |t|
  t.add_link 'bin/loadaverage', 'bin/loadaverage'
  t.add_link 'bin/used_mem', 'bin/used_mem'
end
DotInstallTask.new :nvim
DotInstallTask.new :node do |t|
  t.add_link 'default-npms', 'default-npms', ENV['NDENV_ROOT'] || '~/.anyenv/envs/ndenv/'
end
DotInstallTask.new :mysql
DotInstallTask.new :python do |t|
  t.add_link 'default-packages', 'default-packages', ENV['PYENV_ROOT'] || '~/.anyenv/envs/pyenv/'
end
DotInstallTask.new :fish
DotInstallTask.new :emacs
DotInstallTask.new :hammerspoon

AnyenvSetupTask.new :anyenv
HomebrewSetupTask.new :brew

task default: ['bksd:bin_mkdir', 'bksd:bin_link', :anyenv, :brew, :git, :vim, :zsh, :ruby, :tmux, :nvim, :node, :mysql, :fish, :emacs]
