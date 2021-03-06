$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'rubygems'
require 'test/unit'
require 'rbconfig'
require 'better/tempfile'
require 'mocha' # must be included last, otherwise it won't work!

def run_script(script, *args)
  output = Better::Tempfile.new('output')
  begin
    output.close
    
    ruby = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name']) + Config::CONFIG['EXEEXT']
    command = [ruby, File.join(File.dirname(__FILE__), script), output.path, *args]
    
    if system(*command)
      File.read(output.path)
    else
      raise "Command failed: #{command.join(' ')}"
    end
  ensure
    output.close if !output.closed?
    output.unlink
  end
end