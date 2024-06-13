module "frontend_service" {
  # recourse data
  source      = "../cloudrun"
  region      = var.region
  project_id  = var.project_id
  name_prefix = var.name_prefix

  # template metadata annotations
  max_scale = var.max_scale # optional

  # service accounts
  service_account_email = google_service_account.frontend_service_sa.email

  # container data
  image = var.image

  resource_limits = {
    cpu    = var.resource_cpu
    memory = var.resource_memory
  }

  # environmental variables
  env_variables = [
    {
      name  = "PROJECT_ID"
      value = var.project_id
    },
    {
      name  = "NODE_ENV"
      value = var.environment
    },
    # {
    #   name  = "API_GATEWAY_URL"
    #   value = google_cloud_run_service.backend_service.status[0].url
    # },
    {
      name = "API_KEY"
      secret_key_ref = {
        name = google_secret_manager_secret.backend_api_key.secret_id
        key  = google_secret_manager_secret_version.backend_api_key_version.version
      }
    },
    {
      name  = "NODE_OPTIONS"
      value = "--inspect"
    },
    {
      name = "FRONTEND_AUTH_CLIENT_ID"
      secret_key_ref = {
        name = google_secret_manager_secret.owner_client_id.secret_id
        key  = google_secret_manager_secret_version.owner_client_id_version.version
      }
    },
    {
      name = "FRONTEND_AUTH_CLIENT_SECRET"
      secret_key_ref = {
        name = google_secret_manager_secret.owner_private_key.secret_id
        key  = google_secret_manager_secret_version.owner_private_key_version.version
      }
    },
    {
      name = "NEXT_PUBLIC_FIREBASE_API_KEY"
      secret_key_ref = {
        name = google_secret_manager_secret.next_public_firebase_api_key.secret_id
        key  = google_secret_manager_secret_version.next_public_firebase_api_key_version.version
      }
    },
    {
      name = "NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN"
      secret_key_ref = {
        name = google_secret_manager_secret.next_public_firebase_auth_domain.secret_id
        key  = google_secret_manager_secret_version.next_public_firebase_auth_domain_version.version
      }
    },
    {
      name = "NEXT_PUBLIC_FIREBASE_PROJECT_ID"
      secret_key_ref = {
        name = google_secret_manager_secret.next_public_firebase_project_id.secret_id
        key  = google_secret_manager_secret_version.next_public_firebase_project_id_version.version
      }
    },
    {
      name = "NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID"
      secret_key_ref = {
        name = google_secret_manager_secret.next_public_firebase_messaging_sender_id.secret_id
        key  = google_secret_manager_secret_version.next_public_firebase_messaging_sender_id_version.version
      }
    },
    {
      name = "USE_SECURE_COOKIES"
      secret_key_ref = {
        name = google_secret_manager_secret.use_secure_cookies.secret_id
        key  = google_secret_manager_secret_version.use_secure_cookies_version.version
      }
    },
    {
      name = "NEXT_PUBLIC_FIREBASE_APP_ID"
      secret_key_ref = {
        name = google_secret_manager_secret.next_public_firebase_app_id.secret_id
        key  = google_secret_manager_secret_version.next_public_firebase_app_id_version.version
      }
    },
    {
      name = "NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET"
      secret_key_ref = {
        name = google_secret_manager_secret.next_public_firebase_storage_bucket.secret_id
        key  = google_secret_manager_secret_version.next_public_firebase_storage_bucket_version.version
      }
    },
    {
      name = "FIREBASE_ADMIN_CLIENT_EMAIL"
      secret_key_ref = {
        name = google_secret_manager_secret.firebase_admin_client_email.secret_id
        key  = google_secret_manager_secret_version.firebase_admin_client_email_version.version
      }
    },
    {
      name = "FIREBASE_ADMIN_PRIVATE_KEY"
      secret_key_ref = {
        name = google_secret_manager_secret.firebase_admin_private_key.secret_id
        key  = google_secret_manager_secret_version.firebase_admin_private_key_version.version
      }
    },
    {
      name = "AUTH_COOKIE_NAME"
      secret_key_ref = {
        name = google_secret_manager_secret.auth_cookie_name.secret_id
        key  = google_secret_manager_secret_version.auth_cookie_name_version.version
      }
    },
    {
      name = "AUTH_COOKIE_SIGNATURE_KEY_CURRENT"
      secret_key_ref = {
        name = google_secret_manager_secret.auth_cookie_signature_key_current.secret_id
        key  = google_secret_manager_secret_version.auth_cookie_signature_key_current_version.version
      }
    },
    {
      name = "AUTH_COOKIE_SIGNATURE_KEY_PREVIOUS"
      secret_key_ref = {
        name = google_secret_manager_secret.auth_cookie_signature_key_previous.secret_id
        key  = google_secret_manager_secret_version.auth_cookie_signature_key_previous_version.version
      }
    }
  ]

  # VPC connector
  ip_range_vpc_connector = var.ip_range_vpc_connector
  vpc_network            = var.vpc_network
}

module "ssl" {
  source      = "../ssl"
  project_id  = var.project_id
  name_prefix = var.name_prefix
  domains     = ["${var.domain}"]
  count       = var.environment == "prod" ? 1 : 0
}

module "loadbalancer" {
  source           = "../loadbalancer"
  service          = module.frontend_service
  name_prefix      = var.name_prefix
  project_id       = var.project_id
  region           = var.region
  ssl_certificates = module.ssl[0].certificate
  environment      = var.environment
  count            = var.environment == "prod" ? 1 : 0
}

module "iap_access" {
  source      = "../iap"
  count       = contains(["stag", "acc"], var.environment) ? 1 : 0
  project_id  = var.project_id
  domain      = "${var.environment}.${var.domain}"
  service     = module.frontend_service
  environment = var.environment
}
