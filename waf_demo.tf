terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.7"
    }
  }
}

provider "volterra" {   
    #api_p12_file = var.api_p12_file
    #url          = var.api_url    
}

locals {
  demoFQDN                  = "${var.custName}.${var.demoDomain}"
}
resource "volterra_app_firewall" "app_firewall" {
    name                    = format("%s-app-firewall", var.demoNameSpace)
    namespace               = var.demoNameSpace
    count = var.disableWAF ? 0  : 1 
    allow_all_response_codes = true
    disable_anonymization = true 
    use_default_blocking_page = true
    default_bot_setting = true
    default_detection_settings = true
    blocking = true 
}

resource "volterra_healthcheck" "healthcheck" {
    name                    = format("%s-healthcheck", var.custName)
    namespace               = var.demoNameSpace
    http_health_check {
      host_header           = var.originFQDN
      path                  = "/"
    }
    healthy_threshold       = var.healthy_threshold
    interval                = var.interval
    timeout                 = var.timeout
    unhealthy_threshold     = var.unhealthy_threshold
}

resource "volterra_origin_pool" "origin_pool" {
    name                    = format("%s-origin-pool", var.custName)
    namespace               = var.demoNameSpace
    endpoint_selection      = "LOCAL_PREFERRED"
    loadbalancer_algorithm  = "LB_OVERRIDE"
    healthcheck {
      name                  = volterra_healthcheck.healthcheck.name
      namespace             = volterra_healthcheck.healthcheck.namespace
      tenant                = var.xcTenant
    }
    origin_servers {
            public_name {
                dns_name = var.originFQDN
            }
        }
    port                    = 443 
    use_tls {
      sni = var.originFQDN
      no_mtls = true
      volterra_trusted_ca = true
      tls_config {
        default_security = true
      }
    }
}


resource "volterra_http_loadbalancer" "http_lb" {
    name                    = format("%s-https-lb", var.custName)
    namespace               = var.demoNameSpace    
    description             = format("HTTPS Load balancer for %s domain", var.originFQDN )
    domains                 = [format("%s", local.demoFQDN)]
    advertise_on_public_default_vip = true
    https_auto_cert {
        add_hsts      = false
        http_redirect = true
        no_mtls       = true
    }
    default_route_pools {
      pool {
          name = volterra_origin_pool.origin_pool.name
          namespace = volterra_origin_pool.origin_pool.namespace
      }
    }
    dynamic "app_firewall" {
      for_each = var.disableWAF ? [] : [1]
      content {
        name = var.disableWAF ? null : format("%s-app-firewall", var.demoNameSpace)
        namespace =  var.disableWAF ? null :  var.demoNameSpace
        tenant = var.disableWAF ? null : var.xcTenant 
      }
    }
    disable_waf                     = var.disableWAF

    disable_rate_limit              = true
    round_robin                     = true

    #service policy to apply
    service_policies_from_namespace = var.servicePolicyType == "namespace" ? true : null
    no_service_policies             = var.servicePolicyType == "none" ? true : null
    dynamic "active_service_policies" {
      for_each = var.servicePolicyType == "custom" ? [1] : []
      content { 
        policies {
          name = format("%s-service-policy", var.custName)
          namespace =  var.demoNameSpace
          tenant = var.xcTenant
        }
      }
    }
    #challenge
    no_challenge                    = true    
}
