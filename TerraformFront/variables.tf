variable "amplify_github_token" {
  type        = string
  description = "token to connect github repo"
  default = "AMPLIFY_GITHUB_TOKEN"
  sensitive   = true
}

variable "platform" {
  type        = string
  description = "platform type"
  default     = "WEB_COMPUTE"
}


variable "repository" {
  type        = string
  description = "github repo url"
  default     = "https://github.com/optimalorchestrators/frontend.git"
}

# variable "iam_service_role_arn" {
#   type        = string
#   description = "role IAM"
#   default     = ""
# }

variable "app_name" {
  type        = string
  description = "Morning News Test Front"
  default     = "morningnewstestfront"
}

variable "branch_name" {
  type        = string
  description = "Morning News Repo Branch Name"
  default     = "main"
}


variable "domain_name" {
  type        = string
  default     = "morningnewstestfront.com"
  description = "Morning News Test Front Domain Name"
}