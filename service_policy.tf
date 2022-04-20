resource "volterra_service_policy" "custom" {
  count     = var.servicePolicyType == "custom" ? 1  : 0
  name      = format("%s-service-policy", var.custName)
  namespace = var.demoNameSpace
  algo      = var.algo

  // One of the arguments from this list "deny_list rule_list legacy_rule_list allow_all_requests deny_all_requests internally_generated allow_list" must be set
  
  deny_list {
/*
    asn_list {
      as_numbers = ["[713, 7932, 847325, 4683, 15269, 1000001]"]
    }
    asn_set {
      name      = "test1"
      namespace = "staging"
      tenant    = "acmecorp"
    }
*/
    country_list = var.countryListDeny
    // One of the arguments from this list "default_action_next_policy default_action_deny default_action_allow" must be set
    default_action_next_policy = true
/*
    ip_prefix_set {
      name      = "test1"
      namespace = "staging"
      tenant    = "acmecorp"
    }
    prefix_list {
      prefixes = ["192.168.20.0/24"]
    }
    tls_fingerprint_classes = ["tls_fingerprint_classes"]
    tls_fingerprint_values = ["tls_fingerprint_values"]
*/
  }
  // One of the arguments from this list "any_server server_name server_selector server_name_matcher" must be set
  any_server = true
}