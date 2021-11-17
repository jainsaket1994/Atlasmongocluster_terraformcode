provider "mongodbatlas" {
  alias = "mongoplatform"
}

terraform {
  backend "s3" {
    key = "##StateFile##"
    role_arn = "arn:aws:iam::405524983081:role/AellaAdminRole"
  }
}
