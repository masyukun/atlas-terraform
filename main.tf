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

