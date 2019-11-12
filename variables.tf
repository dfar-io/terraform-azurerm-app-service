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
