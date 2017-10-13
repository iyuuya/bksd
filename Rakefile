require 'fileutils'
require_relative 'tasks/dot_install_task'
require_relative 'tasks/homebrew_setup_task'

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

DotInstallTask.new :ssh do |t|
  t.add_link 'bin/ssh-config', 'bin/ssh-config'
end
DotInstallTask.new :git
DotInstallTask.new :vim do |t|
  t.add_link 'bin/mvim', 'bin/mvim' if /darwin/ =~ RUBY_PLATFORM
end
DotInstallTask.new :zsh
DotInstallTask.new :ruby do |t|
  t.add_link 'default-gems', 'default-gems', ENV['RBENV_ROOT'] || '~/.anyenv/envs/rbenv/'
end
DotInstallTask.new :tmux
DotInstallTask.new :nvim
DotInstallTask.new :node do |t|
  t.add_link 'default-npms', 'default-npms', ENV['NDENV_ROOT'] || '~/.anyenv/envs/ndenv/'
end
DotInstallTask.new :mysql
DotInstallTask.new :python do |t|
  t.add_link 'default-packages', 'default-packages', ENV['PYENV_ROOT'] || '~/.anyenv/envs/pyenv/'
end

HomebrewSetupTask.new :brew

task :default => ['bksd:bin_mkdir', 'bksd:bin_link', :brew, :git, :vim, :zsh, :ruby, :tmux, :nvim, :node, :mysql]
