require 'log4r'
require 'vagrant'

module VagrantPlugins
  module RebootLinux
    module Cap
      class Reboot
        MAX_REBOOT_RETRY_DURATION = 120

        def self.reboot(machine)
          @logger = Log4r::Logger.new('vagrant::linux::reboot')

          if shutting?(machine)
            @logger.debug('A shutdown is already in progress')
          elsif rebooting?(machine)
            @logger.debug('A reboot is already in progress')
          elsif pending_schutdown?(machine)
            @logger.debug('A shutdown is already scheduled')
          else
            machine.communicate.sudo('sync && reboot')
          end

          machine.ui.info(I18n.t('vagrant.guests.capabilities.rebooting'))

          @logger.debug('Waiting for machine to finish rebooting')

          wait_remaining = MAX_REBOOT_RETRY_DURATION
          begin
            wait_for_reboot(machine)
          rescue Vagrant::Errors::MachineGuestNotReady
            raise if wait_remaining < 0

            @logger.warn('Machine not ready, cannot start reboot yet.'\
                          ' Trying again')
            sleep 5
            wait_remaining -= 5
            retry
          end
        end

        def self.wait_for_reboot(machine)
          while machine.guest.ready? &&
                (shutting?(machine) || rebooting?(machine))
            sleep 5
          end
        end

        def self.shutting?(machine)
          # https://en.wikipedia.org/wiki/Runlevel
          machine.communicate.test("[ $(runlevel | sed 's/.* //') == 0 ]")
        end

        def self.rebooting?(machine)
          # https://en.wikipedia.org/wiki/Runlevel
          machine.communicate.test("[ $(runlevel | sed 's/.* //') == 6 ]")
        end

        def self.pending_schutdown?(machine)
          machine.communicate.test('test -f /run/systemd/shutdown/scheduled')
        end
      end
    end
  end
end
