begin
  require 'active_support/all'
rescue LoadError
  puts 'activesupport is not installed'
end

Pry.config.color = true
Pry.config.editor = 'vim'
Pry.config.pager = 'less'

old_prompt = Pry.config.prompt
version = ''
version << "#{Rails.version}@" if defined?(Rails)
version << RUBY_VERSION
Pry.config.prompt = old_prompt.map do |prompt|
  proc { |*a| "#{version} #{prompt.call(*a)}" }
end

# ==============================================================================
# AwesomePrint
begin
  require 'awesome_print'
rescue LoadError
  puts 'awesome_print is not installed'
else
  AwesomePrint.pry!
end

Pry.commands.alias_command 'x',  'exit'
Pry.commands.alias_command 'q',  'exit'
Pry.commands.alias_command 'q!', 'exit-program'
Pry.commands.alias_command 'h',  'help'

# pry-debugger
if Pry.plugins.key? 'debugger'
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# vim: ft=ruby
