# Resource: Service Account, ClusteRole, ClusterRoleBinding

# Datasource
//download do cloudwatch agent service account para acesso ao clowdwatch
data "http" "get_cwagent_serviceaccount" {
  url = "https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/cwagent/cwagent-serviceaccount.yaml"
  # Optional request headers
  request_headers = {
    Accept = "text/*"
  }
}

# Datasource: kubectl_file_documents 
# This provider provides a data resource kubectl_file_documents to enable ease of splitting multi-document yaml content.
data "kubectl_file_documents" "cwagent_docs" {
    content = data.http.get_cwagent_serviceaccount.body // body do get_cwagent_serviceaccount baixado, contem os yml para criacao do agente
}

# Resource: kubectl_manifest which will create k8s Resources from the URL specified in above datasource
// criar os yml do get_cwagent_serviceaccount 
resource "kubectl_manifest" "cwagent_serviceaccount" {
    depends_on = [kubernetes_namespace_v1.amazon_cloudwatch]
    for_each = data.kubectl_file_documents.cwagent_docs.manifests
    yaml_body = each.value
}