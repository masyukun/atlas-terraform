terraform {
  required_version = ">= 1.3.0"
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.14" # Ensures compatibility with Atlas Resource Policy resources
    }
  }
}

# Provider configuration (uses environment variables for credentials)
provider "mongodbatlas" {}

# Variable for your MongoDB Atlas Organization ID
variable "org_id" {
  type        = string
  description = "The 24-character MongoDB Atlas Organization ID where the policy will be applied."
}

# Resource Policy Definition
resource "mongodbatlas_resource_policy" "require_sharded_clusters" {
  org_id      = var.org_id
  name        = "require-sharded-clusters"
  description = "Enforces requirement for all clusters to be sharded."

  policies = [
    {
      body = <<EOF
forbid (
  principal,
  action == ResourcePolicy::Action::"cluster.modify",
  resource
) unless {
  context.cluster.clusterType == ResourcePolicy::ClusterType::"sharded"
};
EOF
    }
  ]
}

# Output the generated Resource Policy ID
output "resource_policy_id" {
  value       = mongodbatlas_resource_policy.require_sharded_clusters.id
  description = "The unique ID of the applied MongoDB Atlas Resource Policy."
}

