# vagrant_reboot_linux
![Gem](https://img.shields.io/gem/dtv/vagrant_reboot_linux.svg?style=for-the-badge)

Vagrant Plugin that implement Reboot guest capability for Linux.
https://www.vagrantup.com/docs/provisioning/shell.html#reboot

# Installation

```bash
vagrant plugin install vagrant_reboot_linux
```

# Usage

See [Example Vagranfile](./example/Vagrantfile)

```ruby
Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/bionic64'

  config.vm.provision 'shell',
                      reboot: true,
                      inline: 'echo BRFORE_REBOOT'

  config.vm.provision 'shell',
                      inline: 'echo AFTER_REBOOT'
end

```
