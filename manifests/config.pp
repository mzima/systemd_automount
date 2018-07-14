# Define: systemd_automount::config
#
# This module creates the systemd automount entries
#
# Parameters:
#   [*mountpoint*]
#     Directory to use as mountpoint for the source device (e.g. /mnt)
#
#   [*source*]
#     Source device or network filesystem (e.g. 192.168.0.1:/export/fs1) 
#
#   [*fstype*]
#     Filesystem type (e.g. nfs4, cifs ...)
#
#   [*ensure*]
#     Set this parameters value to "absent" to remove the autmount entry
#     Values: true/false
#
#   [*dump*]
#     fstab dump entry. See "man fstab". 
#
#   [*pass*]
#     fstab pass entry. See "man fstab". 
#
#   [*atboot*]
#     Set this to "false" if you don't want this filesystem to be active
#     after reboot or when "mount -a" is given.
#
#   [*running*]
#     Set this to false to disable the systemd mount unit.
#
define systemd_automount::config (
  String $mountpoint = $name,
  String $source     = undef,
  Optional[String]  $fstype  = $systemd_automount::params::fstype,
  Optional[String]  $options = $systemd_automount::params::options,
  Optional[String]  $ensure  = $systemd_automount::params::ensure,
  Optional[Integer] $dump    = $systemd_automount::params::dump,
  Optional[Integer] $pass    = $systemd_automount::params::pass,
  Optional[Boolean] $atboot  = $systemd_automount::params::atboot,
  Optional[Boolean] $running = $systemd_automount::params::running,) {

  # Convert mount path into systemd unit name
  $systemd_unit = systemd_automount::systemd_escape($mountpoint)

  # Translate atboot parameter
  if $atboot {
    $auto = 'auto'
  } else {
    $auto = 'noauto'
  }

  # Add fstab entry
  mount { $mountpoint:
    ensure  => 'present',
    name    => $mountpoint,
    device  => $source,
    fstype  => $fstype,
    options => "x-systemd.automount,${auto},${options}",
  }

  # Refresh systemd configuration
  ~>  exec { "refesh_systemd-${mountpoint}":
        command     => 'systemctl daemon-reload',
        path        => ['/sbin', '/usr/sbin', '/bin', '/usr/bin'],
        refreshonly => true
      }

  # Enable automount unit
  ~>  service { "${systemd_unit}.automount":
        ensure => $running,
      }
}
