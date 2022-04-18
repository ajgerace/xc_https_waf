
variable "api_p12_file" {
    type            = string
    default         = "/home/gerace/Documents/terraform/volterra/f5-amer-ent.volterra.io.api-creds.p12"
}
variable "api_url" {
    type            = string
    default         = "https://f5-amer-ent.console.ves.volterra.io/api"
}
variable "custName" {
    description     = "A string containing the customer name"
    type            = string 
}
variable "xcTenant" {
    type            = string 
    default         = "f5-amer-ent-qyyfhhfj"
}
variable "demoNameSpace" {
    description     = "A string containing the namespace in the F5 Distributed Cloud Environment"
    type            = string
    default         = "a-gerace"
}
variable "disableWAF" {
    description     = "Enable or Disable WAF - default is true"
    type            = bool 
    default         = true
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