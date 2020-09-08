variable "name" {
  description = "Name of app service."
}
variable "app_service_plan_name" {
  description = "Name of app service plan."
}
variable "rg_location" {
  description = "Resource Group location."
}
variable "rg_name" {
  description = "Resource Group name."
}
variable "tier" {
  description = "App Service Plan tier."
}
variable "size" {
  description = "App Service Plan size."
}

/* optional */
variable "app_settings" {
  description = "App Service's configuration values."
  default     = {}
}
variable "always_on" {
  description = "Whether the App Service should always be on (Basic or above required)."
  default     = false
}
variable "https_only" {
  description = "Whether the App Service only allows HTTPS connections."
  default     = false
}
variable "use_32_bit_worker_process" {
  description = "Whether the App Service should use the 32-bit worker process (needed for free plans, will be overwritten if Free tier selected)."
  default     = false
}
variable "ip_restrictions" {
  description = "A list of IP addresses allowed to access the App Service."
  type = list(object({
    ip_address = string
    name = string
    action = string
    priority = number
    virtual_network_subnet_id = string
    subnet_id = string
  }))
  default     = []
}