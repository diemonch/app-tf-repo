provider "aws" {
  region = "us-east-1"  # Change this to your AWS region
}

# Cognito User Pool
resource "aws_cognito_user_pool" "react_user_pool" {
  name = "MyReactAppUserPool"

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }
}

# Cognito App Client (For Authentication)
resource "aws_cognito_user_pool_client" "react_app_client" {
  name = "MyReactAppClient"
  user_pool_id = aws_cognito_user_pool.react_user_pool.id

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
}

# Cognito Identity Pool (For Federated Identity)
resource "aws_cognito_identity_pool" "react_identity_pool" {
  identity_pool_name = "ReactIdentityPool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    provider_name = aws_cognito_user_pool.react_user_pool.endpoint
    client_id = aws_cognito_user_pool_client.react_app_client.id
  }
}

# Output Cognito Details
output "user_pool_id" {
  value = aws_cognito_user_pool.react_user_pool.id
}

output "app_client_id" {
  value = aws_cognito_user_pool_client.react_app_client.id
}

output "identity_pool_id" {
  value = aws_cognito_identity_pool.react_identity_pool.id
}