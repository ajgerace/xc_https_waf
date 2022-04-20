variable "custName" {
    description     = "A string containing the customer name"
    type            = string 
}
variable "xcTenant" {
    type            = string 
}
variable "demoDomain" {
    description     = "Enter the name of a delegated subdomain to be used by the HTTP load balancer (ex. cloud.example.com): "
    type            = string

}
variable "demoNameSpace" {
    description     = "A string containing the namespace in the F5 Distributed Cloud Environment"
    type            = string
}
variable "disableWAF" {
    description     = "Enable or Disable WAF - default is true"
    type            = bool 
    default         = false
}
variable "originFQDN" {
    description     = "A string containing the origin FQDN"
    type            = string
}
variable "healthy_threshold" {
    description     = "An number representing the number of successful healthchecks to deem origin server to be healthy"
    type            = number
    default         =  3
}
variable "interval" {
    description     = "A number representing how often to run healthcheck"
    type            = number
    default         =  15    
}                    
variable "timeout"  {
    description     = "A number representing how long before marking a health probe as failed"
    type            = number
    default         = 3
}
variable "unhealthy_threshold" {
    description     = "A number representing how many failed health probes before marking origin server as unavailable"
    type            =  number
    default         = 1
} 

# Service Policy Variables
variable "servicePolicyType" {
    description = "defines if/how Service Policy is created and associated"
    type        = string
    default     = "namespace"

  validation {
    condition     = contains(["custom", "namespace", "none"], var.servicePolicyType)
    error_message = "Valid values for var servicePolicyType are custom, namespace, or none."
  } 
}
##variables to control configurable settings in service policy
variable "countryListDeny" {
    description = "List of countries to Deny. Default values are OFAC sanctioned countries. See https://community.f5.com/t5/technical-articles/how-to-use-f5-distributed-cloud-to-block-ofac-sanctioned/ta-p/292908"
    type = list
    default = [
        "COUNTRY_BY",
        "COUNTRY_BA",
        "COUNTRY_BI",
        "COUNTRY_CF",
        "COUNTRY_CU",
        "COUNTRY_IR",
        "COUNTRY_IQ",
        "COUNTRY_KP",
        "COUNTRY_XK",
        "COUNTRY_LY",
        "COUNTRY_MK",
        "COUNTRY_SO",
        "COUNTRY_SD",
        "COUNTRY_SY",
        "COUNTRY_ZW",
        "COUNTRY_CD",
        "COUNTRY_LB",
        "COUNTRY_NI",
        "COUNTRY_RU",
        "COUNTRY_SS",
        "COUNTRY_VE",
        "COUNTRY_YE"
    ]
}
variable "algo" {
    description = "Matching algorithm for service policy. See https://docs.cloud.f5.com/docs/api/service-policy"
    type = string
    default = "DENY_OVERRIDES"
}
