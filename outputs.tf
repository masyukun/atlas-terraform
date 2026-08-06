# Output the generated Resource Policy ID
output "resource_policy_id" {
  value       = mongodbatlas_resource_policy.require_sharded_clusters.id
  description = "The unique ID of the applied MongoDB Atlas Resource Policy."
}
