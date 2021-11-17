######################################################################
#                               COMMON
######################################################################
variable "region" {
    description = "region"
    type = string
}

variable "env_tags" {
    description = "Additional environment tags"
    type        = map(string)
}

# ------ MongoDB -------

variable "provider_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "num_shards" {
  type = number
}

variable "repli_01_region_name" {
  type = string
}

variable "repli_01_electable_nodes" {
  type = number
}

variable "repli_01_priority" {
  type = number
}

variable "repli_01_read_only_nodes" {
  type = number
}

variable "provider_backup_enabled" {
  type = bool
}

variable "auto_scaling_disk_gb_enabled" {
  type = bool
}

variable "auto_scaling_compute_enabled" {
  type = bool
}

variable "provider_auto_scaling_compute_max_instance_size" {
  type = string
}

variable "auto_scaling_compute_scale_down_enabled" {
  type = bool
}

variable "provider_auto_scaling_compute_min_instance_size" {
  type = string
}

variable "mongo_db_major_version" {
  type = string
}

variable "disk_size_gb" {
  type = number
}

variable "provider_instance_size_name" {
  type = string
}

variable "encryption_at_rest_provider" {
  type = string
}

variable "backup_enabled" {
  type = bool
}
