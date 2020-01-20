resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = var.rg_location
  resource_group_name = var.rg_name

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
    always_on                 = var.always_on
    use_32_bit_worker_process = var.tier == "Free" ? true : var.use_32_bit_worker_process
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
  }
}
