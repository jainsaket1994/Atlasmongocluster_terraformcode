locals {
  new_env_name = "${var.env_tags.Environment}" == "dev-sandbox" ? "devsb" : "${var.env_tags.Environment}"
  name = "${var.env_tags.ServiceGroup}-${var.env_tags.Company}-${var.env_tags.Project}-${local.new_env_name}"
}

resource "mongodbatlas_cluster" "cluster" {
  project_id   = var.project_id
  name         = local.name
  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = var.num_shards
    regions_config {
      region_name     = var.repli_01_region_name
      electable_nodes = var.repli_01_electable_nodes
      priority        = var.repli_01_priority
      read_only_nodes = var.repli_01_read_only_nodes
    }
  }
  provider_backup_enabled                         = var.provider_backup_enabled
  auto_scaling_compute_enabled                    = var.auto_scaling_compute_enabled
  provider_auto_scaling_compute_max_instance_size = var.provider_auto_scaling_compute_max_instance_size
  auto_scaling_compute_scale_down_enabled         = var.auto_scaling_compute_scale_down_enabled
  provider_auto_scaling_compute_min_instance_size = var.provider_auto_scaling_compute_min_instance_size
  auto_scaling_disk_gb_enabled                    = var.auto_scaling_disk_gb_enabled
  mongo_db_major_version                          = var.mongo_db_major_version

  //Provider Settings "block"
  provider_name               = var.provider_name
  disk_size_gb                = var.disk_size_gb
  backup_enabled              = var.backup_enabled
  provider_instance_size_name = var.provider_instance_size_name
  encryption_at_rest_provider = var.encryption_at_rest_provider
}

resource "mongodbatlas_cloud_provider_snapshot_backup_policy" "backup_policy" {
  count        = var.backup_enabled ? 1 : 0
  project_id   = var.project_id
  cluster_name = mongodbatlas_cluster.cluster.name

  reference_hour_of_day    = 17
  reference_minute_of_hour = 0
  restore_window_days      = 5

  //Keep all 4 default policies but modify the units and values
  //Could also just reflect the policy defaults here for later management
  policies {
    id = mongodbatlas_cluster.cluster.snapshot_backup_policy.0.policies.0.id

    policy_item {
      id                 = mongodbatlas_cluster.cluster.snapshot_backup_policy.0.policies.0.policy_item.0.id
      frequency_interval = 1
      frequency_type     = "hourly"
      retention_unit     = "days"
      retention_value    = 1
    }

    policy_item {
      id                 = mongodbatlas_cluster.cluster.snapshot_backup_policy.0.policies.0.policy_item.1.id
      frequency_interval = 1
      frequency_type     = "daily"
      retention_unit     = "days"
      retention_value    = 2
    }

    policy_item {
      id                 = mongodbatlas_cluster.cluster.snapshot_backup_policy.0.policies.0.policy_item.3.id
      frequency_interval = 5
      frequency_type     = "monthly"
      retention_unit     = "months"
      retention_value    = 4
    }
  }
}
