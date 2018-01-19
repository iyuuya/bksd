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

# ==============================================================================
# Hirb
begin
  require 'hirb'
  require 'hirb-unicode'
rescue LoadError
  # puts 'hirb is not installed'
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end
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
