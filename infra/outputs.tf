output "user_pool_id" {
  value = aws_cognito_user_pool.react_user_pool.id
}

output "app_client_id" {
  value = aws_cognito_user_pool_client.react_app_client.id
}

output "identity_pool_id" {
  value = aws_cognito_identity_pool.react_identity_pool.id
}