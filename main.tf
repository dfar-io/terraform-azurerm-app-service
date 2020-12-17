terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "~> 2.38"
    }
  }
}

resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name != null ? var.app_service_plan_name : "${var.name}-asp"
  location            = var.rg_location
  resource_group_name = var.rg_name
  kind                = var.is_containerized ? "Linux" : var.app_service_plan_kind
  reserved            = var.app_service_plan_kind == "Linux" || var.is_containerized

  sku {
    tier = var.tier
    size = var.size
  }
}

resource "azurerm_app_service" "as" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  app_settings        = var.app_settings
  https_only          = var.https_only
  site_config {
    dotnet_framework_version  = var.dotnet_framework_version
    always_on                 = var.always_on
    use_32_bit_worker_process = var.tier == "Free" || var.tier == "Shared" ? true : var.use_32_bit_worker_process
    default_documents = [
      "Default.htm",
      "Default.html",
      "Default.asp",
      "index.htm",
      "index.html",
      "iisstart.htm",
      "default.aspx",
      "index.php",
      "hostingstart.html",
    ]
    
    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        ip_address = ip_restriction.value["cidr_ip"]
        name       = ip_restriction.value["name"]
        action     = "Allow"
        priority   = ip_restriction.key + 1
      }
    }

    linux_fx_version = var.is_containerized ? "DOCKER|${var.registry_name}/${var.image_name}:latest" : ""
  }

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value["name"]
      type  = connection_string.value["type"]
      value = connection_string.value["value"]
    }
  }

  logs {
    application_logs {
      file_system_level = var.application_logs_file_system_level
    }
  }

  # will deploy image above once, then ignore for future deployments
  lifecycle {
    ignore_changes = [
      site_config.0.linux_fx_version
    ]
  }
}

resource "azurerm_app_service_slot" "rc" {
  count               = var.is_blue_green_deployment_enabled ? 1 : 0
  name                = "rc"
  app_service_name    = azurerm_app_service.as.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  app_settings        = var.app_settings

  site_config {
    auto_swap_slot_name = "production"
    dotnet_framework_version  = var.dotnet_framework_version
    always_on                 = var.always_on
    use_32_bit_worker_process = var.tier == "Free" || var.tier == "Shared" ? true : var.use_32_bit_worker_process
    default_documents = [
      "Default.htm",
      "Default.html",
      "Default.asp",
      "index.htm",
      "index.html",
      "iisstart.htm",
      "default.aspx",
      "index.php",
      "hostingstart.html",
    ]
    
    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        ip_address = ip_restriction.value["cidr_ip"]
        name       = ip_restriction.value["name"]
        action     = "Allow"
        priority   = ip_restriction.key + 1
      }
    }

    linux_fx_version = var.is_containerized ? "DOCKER|${var.registry_name}/${var.image_name}:latest" : ""
  }

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value["name"]
      type  = connection_string.value["type"]
      value = connection_string.value["value"]
    }
  }

  logs {
    application_logs {
      file_system_level = var.application_logs_file_system_level
    }
  }

  # will deploy image above once, then ignore for future deployments
  lifecycle {
    ignore_changes = [
      site_config.0.linux_fx_version
    ]
  }
}