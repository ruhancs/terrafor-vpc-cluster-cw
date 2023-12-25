# Resource: CloudWatch Agent ConfigMap
resource "kubernetes_config_map_v1" "cwagentconfig_configmap" {
  metadata {
    name = "cwagentconfig" 
    namespace = kubernetes_namespace_v1.amazon_cloudwatch.metadata[0].name //namespace que sera criado o configmap cwagent
  }
  data = {
    "cwagentconfig.json" = jsonencode({ // yml do configmap
      "logs": {
        "metrics_collected": {
          "kubernetes": {
            "metrics_collection_interval": 60
          }
        },
        "force_flush_interval": 5
      }
    })
  }
}