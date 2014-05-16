$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'cocaine'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

def laptop_vagrantfiles
#   Dir['./test/Vagrantfile.*']
  %w|./test/Vagrantfile.debian-jessie-64|
end

def bring_vagrant_up
  Cocaine::CommandLine.new('vagrant up').run
end

def destroy_vagrant
  Cocaine::CommandLine.new('vagrant destroy --force').run
end

def link_vagrantfile(vagrantfile)
  vagrantfile_name = 'Vagrantfile'

  if File.symlink?(vagrantfile_name)
    File.unlink(vagrantfile_name)
  end
  File.symlink(vagrantfile, vagrantfile_name)
end

def laptop_application_to(vagrantfile)


end
