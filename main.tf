resource "azurerm_app_service_plan" "asp" {
  name                = "${var.app_service_plan_name}"
  location            = "${var.rg_location}"
  resource_group_name = "${var.rg_name}"

  sku {
    tier = "${var.tier}"
    size = "${var.size}"
  }
}

resource "azurerm_app_service" "as" {
  name                = "${var.name}"
  location            = "${var.rg_location}"
  resource_group_name = "${var.rg_name}"
  app_service_plan_id = "${azurerm_app_service_plan.asp.id}"
}
