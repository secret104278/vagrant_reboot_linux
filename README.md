# vagrant_reboot_linux
Vagrant Plugin that implement Reboot guest capability to Linux.
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
