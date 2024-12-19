terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  access_key = TF_VAR_aws_access_key_id
  secret_key = TF_VAR_aws_secret_access_key
  region = "eu-west-3"
}

# Création de l'application
resource "aws_amplify_app" "morningnewstestfront" {
  name         = var.app_name
  repository   = var.repository
  access_token = TF_VAR_amplify_github_token
  platform     = var.platform
  # iam_service_role_arn = aws_iam_role.amplify_role.arn

  # The default build_spec added by the Amplify Console for React.
  build_spec = <<-EOT
  version: 0.1
  frontend:
      phases:
        preBuild:
          commands:
            - npm ci --cache .npm --prefer-offline
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: .next
        files:
          - '**/*'
      cache:
        paths:
          - .next/cache/**/*
          - .npm/**/*
  EOT

  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }
}

# Création d'une branche
resource "aws_amplify_branch" "amplify_branch" {
  app_id      = aws_amplify_app.morningnewstestfront.id
  branch_name = var.branch_name
}

# Création d'un domaine
resource "aws_amplify_domain_association" "domain_association" {
  app_id                = aws_amplify_app.morningnewstestfront.id
  domain_name           = var.domain_name
  wait_for_verification = false

  sub_domain {
    branch_name = aws_amplify_branch.amplify_branch.branch_name
    prefix      = var.branch_name
  }

}

resource "null_resource" "amplify_deployment" {
  depends_on = [var.branch_name]

  provisioner "local-exec" {
    command = "aws amplify start-job --app-id ${aws_amplify_app.morningnewstestfront.id} --branch-name main --job-type RELEASE"
  }
}

# Récupérer l'id de l'application déployée
output "amplify_app_id" {
  value = aws_amplify_app.morningnewstestfront.id
}

# Récupérer l'url de l'application déployée
output "amplify_app_url" {
  value = aws_amplify_domain_association.domain_association.domain_name
}


# resource "aws_amplify_app" "morningnewstestfront" {
#   name       = "morningnewstestfront"
#   repository = "https://gitlab.com/patti.ajavon1/morningnewstestfront.git" # à remplacer

#   # Token de Gitlab
#   access_token = "glpat-YzoxCm86MQp1OmV4YmV6LD95dxTB2LBS82k15Aq8MRA.1706yzrrh"

#   # The default build_spec added by the Amplify Console for Next.js.
#   # build_spec = <<-EOT
#   #   version: 1
#   #   frontend:
#   #     phases:
#   #       preBuild:
#   #         commands:
#   #           - npm ci --cache .npm --prefer-offline
#   #       build:
#   #         commands:
#   #           - npm run build
#   #     artifacts:
#   #       baseDirectory: .next
#   #       files:
#   #         - '**/*'
#   #     cache:
#   #       paths:
#   #         - .next/cache/**/*
#   #         - npm/**/*
#   # EOT

#   # The default rewrites and redirects added by the Amplify Console.
#   # custom_rule {
#   #   source = "/api/<*>"
#   #   status = "404"
#   #   target = "/index.html"
#   # }

#   # environment_variables = {
#   #   ENV = "test"
#   # }
# }
# resource "aws_amplify_branch" "amplify_branch" {
#   app_id      = aws_amplify_app.morningnewstestfront.id
#   branch_name = "main"
# }

# resource "aws_amplify_domain_association" "domain_association" {
#   app_id                = aws_amplify_app.morningnewstestfront.id
#   domain_name           = "morningnewstestfront.com"
#   wait_for_verification = false

#   sub_domain {
#     branch_name = aws_amplify_branch.amplify_branch.branch_name
#     prefix      = "www"
#   }
# }
