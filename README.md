# Azure App Service Module

Terraform Module for creating Azure App Services (Web Apps).

This module requires a Resource Group to be created first for usage.

By default, App Services will be created in the Free tier.

## Usage

### Create App Service

```
resource "azurerm_resource_group" "rg" {
  name     = "RESOURCE_GROUP_NAME"
  location = "Central US"
}

module "app-service" {
  source      = "dfar-io/app-service/azurerm"
  name        = "APP_SERVICE_NAME"
  rg_location = azurerm_resource_group.rg.location
  rg_name     = azurerm_resource_group.rg.name
}
```

### Create App Service with App Settings

```
module "app-service" {
  source       = "dfar-io/app-service/azurerm"
  name         = "APP_SERVICE_NAME"
  rg_location  = azurerm_resource_group.rg.location
  rg_name      = azurerm_resource_group.rg.name
  app_settings = {
      key1 = "value1"
      key2 = "value2"
      key3 = "value3"
  }
}
```

### Create App Service with IP restrictions

```
module "app-service" {
  source          = "dfar-io/app-service/azurerm"
  name            = "APP_SERVICE_NAME"
  rg_location     = azurerm_resource_group.rg.location
  rg_name         = azurerm_resource_group.rg.name
  ip_restrictions = [
    {
      name = "IP"
      cidr_ip = "1.2.3.4/32"
    },
    {
      name = "IP2"
      cidr_ip = "1.2.3.5/32"
    }
  ]
}
```