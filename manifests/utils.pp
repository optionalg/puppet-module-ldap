# Define: ldap::utils
#
# This module manages ldap
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
define ldap::utils (
  $ensure           = $ldap::utils::config::ensure,
  $base_dn          = $ldap::utils::config::base_dn,
  $root_cn          = $ldap::utils::config::root_cn,
  $password         = $ldap::utils::config::password,
  $ldap_uri         = $ldap::utils::config::ldap_uri,
  $search_timelimit = $ldap::utils::config::search_timelimit,
  $bind_timelimit   = $ldap::utils::config::bind_timelimit,
  $idle_timelimit   = $ldap::utils::config::bind_timelimit,
  $bind_policy      = $ldap::utils::config::bind_policy,
  $ldap_version     = $ldap::utils::config::ldap_version,
  $port             = $ldap::utils::config::port,
  $pam_min_uid      = $ldap::utils::config::pam_min_uid,
  $pam_max_uid      = $ldap::utils::config::pam_max_uid,
  $ssl_mode         = $ldap::utils::config::ssl_mode,
  $ssl_cipher_suite = $ldap::utils::config::ssl_cipher_suite,
  $ssl_verify_certs = $ldap::utils::config::ssl_verify_certs,
  $ssl_rand_file    = $ldap::utils::config::ssl_rand_file,
  $sasl_minssf      = $ldap::utils::config::sasl_minssf,
  $sasl_maxssf      = $ldap::utils::config::sasl_maxssf
) {
  # Ensure our anchor points exist.
  include ldap::anchor

  $packages   = $ldap::utils::config::packages
  $conf_files = $ldap::utils::config::conf_files

  case $ensure {
    'present': {
      package{ $packages:
        ensure => 'present',
        before => Anchor[ 'phase1' ],
      }
    }

    'absent': {
      package{ $packages:
        ensure => 'purged',
      }
    }

    default: {
      fail( "'$ensure' is not a recognized valued for 'ensure'" )
    }
  }

  toggle{ $conf_files:
    ensure     => $ensure,
    require    => Anchor[ 'phase1' ],
    before     => Anchor[ 'phase2' ],
  }
}
