require 'vagrant'

module VagrantPlugins
  module RebootLinux
    class Plugin < Vagrant.plugin('2')
      name 'Reboot Linux guest'
      description 'Reboot Linux guest support.'
      guest_capability 'linux', 'reboot' do
        require_relative 'cap/reboot'
        Cap::Reboot
      end
    end
  end
end
