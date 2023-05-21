# https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard/6.0.7
resource "helm_release" "kubernetes-dashboard" {
  name       = "kubernetes-dashboard"
  create_namespace = true

  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  namespace  = "kubernetes-dashboard"
  version    = "6.0.7"

  values = [data.template_file.values.rendered]
}
