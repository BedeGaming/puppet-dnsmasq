class dnsmasq (
  $service_manage = $dnsmasq::params::service_manage,
  $service_ensure = $dnsmasq::params::service_ensure,
  $config_dir     = $dnsmasq::params::config_dir,
  $package_ensure = 'installed',
) {
  include dnsmasq::params

  anchor { 'dnsmasq::start': }

  class { 'dnsmasq::install': require => Anchor['dnsmasq::start'], }

  class { 'dnsmasq::config': require => Class['dnsmasq::install'], }

  class { 'dnsmasq::service':
    subscribe => Class['dnsmasq::install', 'dnsmasq::config'],
  }

  class { 'dnsmasq::reload':
    require => Class['dnsmasq::service'],
  }

  anchor { 'dnsmasq::end': require => Class['dnsmasq::service'], }
  if $::settings::storeconfigs {
    File_line <<| tag == 'dnsmasq-host' |>>
  }
}
