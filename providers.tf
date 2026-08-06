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
# The provider automatically reads MONGODB_ATLAS_PUBLIC_KEY and MONGODB_ATLAS_PRIVATE_KEY from the environment
provider "mongodbatlas" {}
