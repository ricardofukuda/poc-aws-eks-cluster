module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.13.1"

  cluster_name    = "eks-${var.env}"
  cluster_version = "1.24"

  cluster_endpoint_public_access  = true # TEST ONLY
  cluster_endpoint_private_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
      service_account_role_arn = module.ebs_csi_role.iam_role_arn
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = [] # empty to force each nodegroup to configure it
  control_plane_subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"

    subnet_ids = module.vpc.private_subnets # by default, we use private subnets

    network_interfaces = [
      {
        associate_public_ip_address = false # by default, we disable public IPs
      }
    ]
  }

  eks_managed_node_groups = {
    apps = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      disk_size = 20

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"
    }
  }

  create_kms_key = true
  kms_key_deletion_window_in_days = 7

  create_cloudwatch_log_group = false # disable cloudwatch logging
  cluster_enabled_log_types = [] # disable cloudwatch logging

  manage_aws_auth_configmap = true # MUST be true to make the ec2 nodes reachable
  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/admin"
      username = ""
      groups   = ["system:masters"]
    }
  ]

  tags = var.tags
}
