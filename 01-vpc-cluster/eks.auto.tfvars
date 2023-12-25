cluster_name = "eksdemo1"
cluster_service_ipv4_cidr = "172.20.0.0/16"
cluster_version = "1.26"
cluster_endpoint_private_access = false
cluster_endpoint_public_access = true // permite acesso do node group publico ao eks control plane da aws, control plane recebera comando do kubectl via maquina local
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] // aberto para internet para acessar o control plane
eks_oidc_root_ca_thumbprint = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280" //id do eks cluster