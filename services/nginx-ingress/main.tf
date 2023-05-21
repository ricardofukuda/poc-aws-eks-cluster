# https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx/4.6.1
resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  create_namespace = true

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  version    = "4.6.1"

  values = [data.template_file.values.rendered]
}