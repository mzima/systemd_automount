# Class: systemd_automount
#
# This module manages systemd automount entries
#
# Parameters:
#   [*override*]
#     Skip the execution of this module. This parameter can be used for debugging purposes.
#     Default: false
#
#   [*mounts*]
#     Hash definition of the automount configuration. Consult the README.md file for examples.
#     Default: emtpy
#
class systemd_automount (Optional[Hash] $mounts = {}, Optional[Boolean] $override = false) inherits
systemd_automount::params {

  unless $override {
    # Realize hash based configuration
    create_resources(systemd_automount::config, $mounts)
  } else {
    notice('Parameter $override is set. Skipping execution.')
  }
}
