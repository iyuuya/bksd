require_relative 'tasks/dot_install_task'
require_relative 'tasks/homebrew_setup_task'

DotInstallTask.new :ssh do |t|
  t.add_link 'bin/ssh-config', 'bin/ssh-config'
end
DotInstallTask.new :git
DotInstallTask.new :vim do |t|
  t.add_link 'bin/mvim', 'bin/mvim' if /darwin/ =~ RUBY_PLATFORM
end
DotInstallTask.new :zsh
DotInstallTask.new :ruby do |t|
  t.add_link 'default-gems', 'default-gems', ENV['RBENV_ROOT']
end
DotInstallTask.new :tmux

HomebrewSetupTask.new :brew

task :default => [:brew, :git, :vim, :zsh, :ruby, :tmux]

