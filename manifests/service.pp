class dnsmasq::service {
  if ($dnsmasq::service_manage) {
    service { $dnsmasq::params::service_name:
      ensure     => $dnsmasq::service_ensure,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
    }
  }
}
