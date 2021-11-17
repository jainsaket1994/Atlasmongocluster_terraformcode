output "cluster_id" {
  value       = mongodbatlas_cluster.cluster.cluster_id
}

output "cluster_name" {
  value       = local.name
}

output "mongo_db_version" {
  value       = mongodbatlas_cluster.cluster.mongo_db_version
}

output "mongo_uri" {
  value       = mongodbatlas_cluster.cluster.mongo_uri
}

output "mongo_uri_updated" {
  value       = mongodbatlas_cluster.cluster.mongo_uri_updated
}

output "mongo_uri_with_options" {
  value       = mongodbatlas_cluster.cluster.mongo_uri_with_options
}

output "connection_strings_aws_private_link" {
  value       = mongodbatlas_cluster.cluster.connection_strings
}
