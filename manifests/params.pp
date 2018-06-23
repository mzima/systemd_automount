# Class: systemd_automount::params
#
# This module manages systemd automount module default parameter
#
class systemd_automount::params {

  # Default mount options
  $options = ''
  # Default filesystem type
  $fstype = 'nfs4'
  # Default fstab dump setting
  $dump = 0
  # Default fstab pass setting
  $pass = 0
  # Set ensure to absent to remove an automount entry
  $ensure = 'present'
  # Set atboot to false to disable the automount feature
  $atboot = true
  # Set running to false to disable the automount in systemd
  $running = true
}
