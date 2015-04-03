# Hirb

Pry.config.color = true
Pry.config.editor = "vim"
Pry.config.pager = "less"

old_prompt = Pry.config.prompt
version = ""
version << "#{Rails.version}@" if defined?(Rails)
version << "#{RUBY_VERSION}"
Pry.config.prompt = old_prompt.map { |prompt| proc { |*a| "#{version} #{prompt.call(*a)}" } }
# [
#   proc { |*a| "#{version} #{old_prompt[0].call(*a)}" },
#   proc { |*a| "#{version} #{old_prompt[1].call(*a)}" }
# ]

begin
  require 'hirb'
  require 'awesome_print'
rescue LoadError
  # Missing goodies, bummer
end

if defined? AwesomePrint
  begin
    require 'awesome_print'
    Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
  rescue LoadError => err
    puts "no awesome_print :("
    puts err
  end
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        (Hirb::View.view_or_page_output(value) || @old_print.call(output, value))
        puts Time.now
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

Pry.commands.alias_command 'e',  'edit'
Pry.commands.alias_command 'q',  'exit'
Pry.commands.alias_command 'q!', 'exit-program'
Pry.commands.alias_command 'h',  'help'

# pry-debugger
if Pry.plugins.has_key? 'debugger'
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# vim: ft=ruby
