# POC AWS EKS Cluster
This terraform deploys a basic eks cluster for testing pourposes. The ELB for the nginx ingress controller is going to be public but restrited to your public IP.

## Terraform Modules Reference
https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/19.13.1

https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/4.0.1

## Automatically Deploys
- NGINX Ingress;
- K8S Dashboard;
- AWS EBS CSI;

## Kubectl config
```
aws eks update-kubeconfig --region us-east-1 --name eks-dev --kubeconfig ~/.kube/eks-dev
export KUBECONFIG=~/.kube/eks-dev
```

## Local Port Forward
```
kubectl port-forward service/kubernetes-dashboard -n kubernetes-dashboard 5000:80
http://localhost:5000
```