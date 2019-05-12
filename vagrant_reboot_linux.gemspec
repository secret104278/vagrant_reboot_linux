# Add the lib directory to the load path so we can get the version file out.
$LOAD_PATH.unshift File.expand_path('lib', __dir__)

require 'vagrant_reboot_linux/version'

Gem::Specification.new do |gem|
  gem.name          = 'vagrant_reboot_linux'
  gem.version       = VagrantPlugins::Cap::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.license       = 'MIT'
  gem.authors       = 'WANG YU-CHIH'
  gem.email         = 'secret104278@gmail.com'
  gem.homepage      = "https://github.com/secret104278/vagrant_reboot_linux"
  gem.description   = 'Guest capability for linux to reboot.'
  gem.summary       = 'Guest capability for linux to reboot.'

  gem.files = `git ls-files -z`.split("\x0")
  gem.require_paths = ['lib']
end
