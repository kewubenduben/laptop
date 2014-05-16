$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'cocaine'
require 'logger'
require 'net/http'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

def laptop_vagrantfiles
#   Dir['./test/Vagrantfile.*']
  %w|./test/Vagrantfile.debian-jessie-64|
end

def run_command(command)
  Cocaine::CommandLine.new(command, '', :logger => Logger.new(STDOUT)).run
end

def run_vagrant_ssh_command(command)
  run_command("vagrant ssh -c '#{command}'")
end

def bring_vagrant_up
  run_command("vagrant up")
end

def destroy_vagrant
  run_command('vagrant destroy --force')
end

def link_vagrantfile(vagrantfile)
  vagrantfile_name = 'Vagrantfile'

  if File.symlink?(vagrantfile_name)
    File.unlink(vagrantfile_name)
  end
  File.symlink(vagrantfile, vagrantfile_name)
end

def laptop_setup
  run_vagrant_ssh_command("echo vagrant | bash /vagrant/linux")
end

def zshell_test
  run_vagrant_ssh_command('[ "$SHELL" = "/usr/bin/zsh" ]')
end

def installed_ruby_version
  run_vagrant_ssh_command("ruby --version")
end

def latest_ruby_version
  Net::HTTP.get(URI("http://ruby.thoughtbot.com/latest")).chomp
end

def generate_rails_app
  run_vagrant_ssh_command("rm -Rf ~/test_app && cd ~ && rails new test_app")
end

def scaffold_and_model_generation
  run_vagrant_ssh_command("cd ~/test_app && rails g scaffold post title:string")
end

def database_migration
  run_vagrant_ssh_command("cd ~/test_app && rake db:create db:migrate db:test:prepare")
end

def silver_searcher_test
  run_vagrant_ssh_command("command -v ag")
end

def prepare_for_packaging
  run_vagrant_ssh_command("rm -Rf ~/test_app")
  run_vagrant_ssh_command("sudo aptitude clean")
end
