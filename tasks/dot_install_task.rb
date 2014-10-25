require 'rake/tasklib'

class DotInstallTask < Rake::TaskLib
  @@bksd_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  def initialize(name)
    @name = name
    @links = {}
    make_list
    yield self if block_given?
    define
  end

  def add_link(src, dst, path="~/")
    @links[File.join(config_path,src)] = File.join(File.expand_path(path), dst)
  end

  def config_path
    File.join(@@bksd_dir,@name.to_s)
  end

  private

  def make_list
    list = Dir.glob("#{@@bksd_dir}/#{@name}/.*").map{|p|p.sub(config_path, '')}
    list.delete("/.")
    list.delete("/..")
    list.delete("/.git")
    list.delete("/.gitignore")
    list.each do |path|
      add_link path, File.basename(path, "")
    end
  end

  def force_ln_links
    @links.each do |src, dst| rm_f dst ; ln_s src, dst end
  end

  def print_links
    @links.each do |src, dst| puts "#{src} -> #{dst}" end
  end

  def define
    task @name => "#{@name}:install"
    namespace @name do
      desc "#{@name} install"
      task :install do force_ln_links end
      desc "#{@name} list"
      task :list do print_links end
    end
  end
end
