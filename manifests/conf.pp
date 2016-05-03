define dnsmasq::conf (
  $ensure     = 'present',
  $prio       = 10,
  $source     = undef,
  $content    = undef,
  $config_dir = $dnsmasq::config_dir,
) {
  include dnsmasq

  file { "${config_dir}${prio}-${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    content => $content,
    source  => $source,
    notify  => Class['dnsmasq::service'],
  }
}
