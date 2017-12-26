require 'rake/tasklib'

class HomebrewSetupTask < Rake::TaskLib
  @@bksd_dir = File.expand_path(File.join(__dir__, '..'))

  def initialize(name)
    @name = name
    yield self if block_given?
    define
  end

  def define
    task @name => ["#{@name}:install", "#{@name}:bundle"]
    namespace @name do
      desc "#{@name} install"
      task :install do
        if open('| which brew 2>/dev/null', &:gets)
          puts 'brew command found!'
        else
          system '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
        end
      end

      desc "#{@name} bundle"
      task :bundle do
        puts 'brew bundle ...'
        system "cd #{@@bksd_dir}/brew; brew bundle"
      end
    end
  end
end
