output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}
output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "host" {
   value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}
/*
output "client_key" {
   value = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
}

output "client_certificate" {
   value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "kube_config" {
   value = azurerm_kubernetes_cluster.aks.kube_config_raw
   sensitive = true
}

output "cluster_username" {
   value = azurerm_kubernetes_cluster.aks.kube_config.0.username
}

output "cluster_password" {
   value = azurerm_kubernetes_cluster.aks.kube_config.0.password
}
*/