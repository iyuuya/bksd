require 'rake/tasklib'

class HomebrewSetupTask < Rake::TaskLib
  @@bksd_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))

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
        unless open("| which brew 2>/dev/null") { |f| f.gets }
          system "git clone https://github.com/Homebrew/homebrew.git ~/brew"
        else
          puts "brew command found!"
        end
      end

      desc "#{@name} bundle"
      task :bundle do
        puts "brew bundle ..."
        system "cd #{@@bksd_dir}/brew; sh Brewfile"
        system "cd #{@@bksd_dir}/brew; sh Caskfile"
      end
    end
  end
end
