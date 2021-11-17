provider "mongodbatlas" {
  alias = "mongoplatform"
}


terraform {
  backend "s3" {
    key = "mongo-atlas/terraform-aws-mongo-atlas.tfstate"
  }
}
