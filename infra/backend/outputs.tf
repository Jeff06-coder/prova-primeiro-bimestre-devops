output "bucket_name" {
  description = "Nome do bucket S3 criado para o state"
  value       = aws_s3_bucket.tf_state.id
}

output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB criada para o lock"
  value       = aws_dynamodb_table.tf_lock.name
}
