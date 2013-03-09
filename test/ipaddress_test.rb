require 'test_helper'

class IPAddressTest < Test::Unit::TestCase

  def test_it_creates_ip_addresses_from_strings

    valid_ipv4_string        = "172.16.10.1/24"
    valid_ipv6_string        = "2001:db8::8:800:200c:417a/64"
    valid_mapped_string      = "::13.1.68.3"

    assert_nothing_raised { IPAddress valid_ipv4_string   }
    assert_nothing_raised { IPAddress valid_ipv6_string   } 
    assert_nothing_raised { IPAddress valid_mapped_string }

    ipv4class   = IPAddress::IPv4
    ipv6class   = IPAddress::IPv6
    mappedclass = IPAddress::IPv6::Mapped

    assert_instance_of ipv4class,   IPAddress(valid_ipv4_string)
    assert_instance_of ipv6class,   IPAddress(valid_ipv6_string)
    assert_instance_of mappedclass, IPAddress(valid_mapped_string)

    invalid_ipv4_string   = "10.0.0.256"
    invalid_ipv6_string   = ":1:2:3:4:5:6:7"
    invalid_mapped_string = "::1:2.3.4"

    assert_raise(ArgumentError) { IPAddress invalid_ipv4_string   }
    assert_raise(ArgumentError) { IPAddress invalid_ipv6_string   }
    assert_raise(ArgumentError) { IPAddress invalid_mapped_string }
  end

  def test_module_method_valid?
    assert_equal true, IPAddress::valid?("10.0.0.1")
    assert_equal true, IPAddress::valid?("10.0.0.0")
    assert_equal true, IPAddress::valid?("2002::1")
    assert_equal true, IPAddress::valid?("dead:beef:cafe:babe::f0ad")
    assert_equal false, IPAddress::valid?("10.0.0.256")
    assert_equal false, IPAddress::valid?("10.0.0.0.0")
    assert_equal false, IPAddress::valid?("10.0.0")
    assert_equal false, IPAddress::valid?("10.0")
    assert_equal false, IPAddress::valid?("2002:::1")
  end

  def test_module_method_valid_ipv4_netmark?
    assert_equal true, IPAddress::valid_ipv4_netmask?("255.255.255.0")
    assert_equal false, IPAddress::valid_ipv4_netmask?("10.0.0.1")
  end
end
