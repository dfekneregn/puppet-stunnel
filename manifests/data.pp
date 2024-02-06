# Class: stunnel::data
#
# Poorly named 'params' class, this class handles all the os-specific logic.
#
class stunnel::data {
  case $facts['os']['family'] {
    /RedHat/: {
      $service = 'stunnel'
      $bin_name = 'stunnel'
      $bin_path = '/usr/bin'
      $config_dir = '/etc/stunnel'
      $pid_dir = '/var/run'
      $conf_d_dir = '/etc/stunnel/conf.d'
      $cert_dir = '/etc/stunnel/certs'
      $log_dir = '/var/log/stunnel'
      $setgid = 'root'
      $setuid = 'root'

      if versioncmp($facts['os']['release']['major'], '7') >= 0 {
        $service_init_system = 'systemd'
      } else {
        $service_init_system = 'sysv'
      }

      if versioncmp($facts['os']['release']['major'], '9') >= 0 {
        $package = [ 'stunnel' ]
      } else {
        $package = [ 'stunnel', 'redhat-lsb' ]
      }

    }
    /Debian/: {
      $package = [ 'stunnel4', 'lsb-base' ]
      $service = 'stunnel'
      $bin_name = 'stunnel4'
      $bin_path = '/usr/bin'
      $config_dir = '/etc/stunnel'
      $pid_dir = '/var/run'
      $conf_d_dir = '/etc/stunnel/conf.d'
      $cert_dir = '/etc/stunnel/certs'
      $log_dir = '/var/log/stunnel4'
      $setgid = 'root'
      $setuid = 'root'

      if ($facts['os']['name'] == 'Ubuntu' and versioncmp($facts['os']['release']['full'], '15.04') >= 0) or
        ($facts['os']['name'] == 'Debian' and versioncmp($facts['os']['release']['full'], '8.0') >= 0) {
        $service_init_system = 'systemd'
      } else {
        $service_init_system = 'sysv'
      }
    }

    default: {
      fail("Unsupported osfamily '${facts['os']['family']}'!")
    }
  }
}
