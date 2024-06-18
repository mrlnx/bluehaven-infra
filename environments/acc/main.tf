module "project_setup" {
  source             = "../../modules/project"
  region             = var.region
  zone               = var.zone
  project_id         = var.project_id
  project_number     = var.project_number
  tf_service_account = var.tf_service_account
  name_prefix        = "build-svc-${var.environment}"
}

module "cloudbuild" {
  source          = "../../modules/cloudbuild"
  name_prefix     = "cb-svc-${var.environment}"
  github_ssh_key  = var.github_ssh_key
  project_service = module.project_setup
  project_id      = var.project_id
  project_number  = var.project_number
}

module "frontend_artifact_repository" {
  source      = "../../modules/artifacts"
  name_prefix = "fe-svc-${var.environment}"
  project_id  = var.project_id
  region      = var.region
}

module "backend_artifact_repository" {
  source      = "../../modules/artifacts"
  name_prefix = "be-svc-${var.environment}"
  project_id  = var.project_id
  region      = var.region
}

module "vpc_network" {
  source        = "../../modules/vpc_network"
  name_prefix   = var.environment
  region        = var.region
  ip_cidr_range = "10.1.0.0/16"
  project_id    = var.project_id
}

module "frontend_service" {
  source                 = "../../modules/frontend_service"
  name_prefix            = "fe-svc-${var.environment}"
  region                 = var.region
  project_id             = var.project_id
  vpc_network            = module.vpc_network
  ip_range_vpc_connector = "10.8.1.0/28"

  environment                              = var.environment
  project_number                           = var.project_number
  project_service                          = module.project_setup
  next_public_firebase_app_id              = var.next_public_firebase_app_id
  auth_cookie_name                         = var.auth_cookie_name
  auth_cookie_signature_key_current        = var.auth_cookie_signature_key_current
  auth_cookie_signature_key_previous       = var.auth_cookie_signature_key_previous
  next_public_firebase_api_key             = var.next_public_firebase_api_key
  next_public_firebase_auth_domain         = var.next_public_firebase_auth_domain
  next_public_firebase_messaging_sender_id = var.next_public_firebase_messaging_sender_id
  next_public_firebase_project_id          = var.next_public_firebase_project_id
  next_public_firebase_storage_bucket      = var.next_public_firebase_storage_bucket
  firebase_admin_private_key               = var.firebase_admin_private_key
  firebase_admin_client_email              = var.firebase_admin_client_email
  backend_api_key                          = var.backend_api_key
  owner_private_key                        = var.owner_private_key
  owner_client_id                          = var.owner_client_id
  domain                                   = "acc.ikhebgeencadeau.nl"
  image                                    = var.fe_docker_image

  base_ip_policy = []
}

module "backend_service_db" {
  source                 = "../../modules/cloudsql"
  name_prefix            = "be-svc-${var.environment}"
  region                 = var.region
  project_id             = var.project_id
  project_service        = module.project_setup
  project_number         = var.project_number
  tier                   = "db-f1-micro"
  instance_name          = "cloud-postgres-instance"
  vpc_network            = module.vpc_network
  vpc_subnet             = module.vpc_network.vpc_subnet
  ip_range_vpc_connector = "10.8.1.16/28"

  depends_on = [module.vpc_network, module.vpc_network.vpc_subnet]
}

module "backend_service" {
  source                 = "../../modules/api_service"
  name_prefix            = "be-svc-${var.environment}"
  region                 = var.region
  project_id             = var.project_id
  project_number         = var.project_number
  project_service        = module.project_setup
  environment            = var.environment
  db_connection          = module.backend_service_db
  vpc_network            = module.vpc_network
  ip_range_vpc_connector = "10.8.1.32/28"
  image                  = var.be_docker_image
}
