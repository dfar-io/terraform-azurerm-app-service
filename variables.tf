// Required
variable "name" {
  description = "App Service name."
}
variable "rg_location" {
  description = "Existing resource group location for App Service to be placed in."
}
variable "rg_name" {
  description = "Existing resource group name for App Service to be placed in."
}

// Optional
variable "app_service_plan_name" {
  description = "Name of app service plan."
  default = null
}
variable "tier" {
  description = "App Service Plan tier."
  default = "Free"
}
variable "size" {
  description = "App Service Plan size."
  default = "F1"
}
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
    name    = string
    cidr_ip = string
  }))
  default     = []
}
variable "is_containerized" {
  description = "Whether the App Service is containerized."
  type = bool
  default = false
}
variable "app_service_plan_kind" {
  description = "The kind of App Service Plan to create (Linux (default), Windows, elastic, FunctionApp), will be overwritten if App Service is containerized."
  type = string
  default = "Linux"
}
variable "registry_name" {
  description = "Registry name for container."
  type = string
  default = ""
}
variable "image_name" {
  description = "Image name for container."
  type = string
  default = ""
}