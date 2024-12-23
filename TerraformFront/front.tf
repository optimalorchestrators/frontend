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
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = "eu-west-3"
}
variable "aws_session_token" {
  description = "AWS session token"
  type        = string
  sensitive   = true
}

# Création de l'application
resource "aws_amplify_app" "morningnewstestfront" {
  name         = var.app_name
  repository   = var.repository
  access_token = var.PATTI_GITHUB_TOKEN
  platform     = var.platform

  # Build_spec est le job qui doit être lancé suite à la création de l'application amplify
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

  # Ajout d'une règle personnalisée pour gérer des erreurs 404 pour l'application. Cette règle est applicable car le site est statique et comporte une seule page
  custom_rule {
    source = "/<*>" # cette règle s'applique à toutes les urls du site, quelque soit le chemin
    status = "404" # cette règle s'applique aux requêtes dont le retour est 404 Page non trouvée
    target = "/index.html" # Lorsqu'une erreur 404 est rencontrée, la requête sera redirigée vers le fichier index.html
  }
}

# Ressource qui permet de créer et de gérer une branche spécifique dans l'application AWS Amplify. Cela permet d'automatiser le déploiement et la gestion des branches
resource "aws_amplify_branch" "amplify_branch" {
  app_id      = aws_amplify_app.morningnewstestfront.id
  branch_name = var.branch_name
}

# Ressource permettant d'associer un domaine personnalisé à l'application AWS Amplify
resource "aws_amplify_domain_association" "domain_association" {
  app_id                = aws_amplify_app.morningnewstestfront.id # le nom de domaine est associé à l'ID de cette application AWS Amplify
  domain_name           = var.domain_name
  wait_for_verification = false # terraform ne doit pas attendre la vérification du domaine pour considérer la ressource comme créée 
# Configuration d'un sous-domaine et l'associe à une branche spécifique de l'application
  sub_domain {
    branch_name = aws_amplify_branch.amplify_branch.branch_name
    prefix      = var.branch_name
  }

}

# Création d'une ressource qui ne crée rien mais qui permet de déclencher un déploiement dans l'application AWS AMplify 
resource "null_resource" "amplify_deployment" { 
  depends_on = [aws_amplify_app.morningnewstestfront]
  provisioner "local-exec" { # permet d'indiquer que la commande ci-dessous sera exécutée en local, sur la machine exécutant le Terraform
    command = "AWS_ACCESS_KEY_ID=${var.aws_access_key_id} AWS_SECRET_ACCESS_KEY=${var.aws_secret_access_key} aws amplify start-job --app-id ${aws_amplify_app.morningnewstestfront.id} --branch-name dev --job-type RELEASE"
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
