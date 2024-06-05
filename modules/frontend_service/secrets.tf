
# create owner secret client = client_email
resource "google_secret_manager_secret" "owner_client_id" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-owner-client-email"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "owner_client_id_version" {
  provider    = google
  secret      = google_secret_manager_secret.owner_client_id.id
  secret_data = var.owner_client_id
}

data "google_secret_manager_secret_version" "owner_client_id_version" {
  provider = google
  secret   = google_secret_manager_secret.owner_client_id.name
  version  = google_secret_manager_secret_version.owner_client_id_version.version
}

# create owner private key = private_key
resource "google_secret_manager_secret" "owner_private_key" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-owner-private-key"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "owner_private_key_version" {
  provider    = google
  secret      = google_secret_manager_secret.owner_private_key.id
  secret_data = var.owner_private_key
}

data "google_secret_manager_secret_version" "owner_private_key_version" {
  provider = google
  secret   = google_secret_manager_secret.owner_private_key.name
  version  = google_secret_manager_secret_version.owner_private_key_version.version
}


# create secret api key for backend api gateway
resource "google_secret_manager_secret" "backend_api_key" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-backend-api-key"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}

resource "google_secret_manager_secret_version" "backend_api_key_version" {
  provider    = google
  secret      = google_secret_manager_secret.backend_api_key.id
  secret_data = var.backend_api_key
}

data "google_secret_manager_secret_version" "backend_api_key_version" {
  provider = google
  secret   = google_secret_manager_secret.backend_api_key.name
  version  = google_secret_manager_secret_version.backend_api_key_version.version
}

# create secret firebase admin client email
resource "google_secret_manager_secret" "firebase_admin_client_email" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-firebase-admin-client-email"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}

resource "google_secret_manager_secret_version" "firebase_admin_client_email_version" {
  provider    = google
  secret      = google_secret_manager_secret.firebase_admin_client_email.id
  secret_data = var.firebase_admin_client_email
}

data "google_secret_manager_secret_version" "firebase_admin_client_email_version" {
  provider = google
  secret   = google_secret_manager_secret.firebase_admin_client_email.name
  version  = google_secret_manager_secret_version.firebase_admin_client_email_version.version
}

# create secret firebase admin private key
resource "google_secret_manager_secret" "firebase_admin_private_key" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-firebase-admin-private-key"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}

resource "google_secret_manager_secret_version" "firebase_admin_private_key_version" {
  provider    = google
  secret      = google_secret_manager_secret.firebase_admin_private_key.id
  secret_data = var.firebase_admin_private_key
}

data "google_secret_manager_secret_version" "firebase_admin_private_key_version" {
  provider = google
  secret   = google_secret_manager_secret.firebase_admin_private_key.name
  version  = google_secret_manager_secret_version.firebase_admin_private_key_version.version
}

# create secret auth cookie name
resource "google_secret_manager_secret" "auth_cookie_name" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-auth-cookie-name"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}

resource "google_secret_manager_secret_version" "auth_cookie_name_version" {
  provider    = google
  secret      = google_secret_manager_secret.auth_cookie_name.id
  secret_data = var.auth_cookie_name
}

data "google_secret_manager_secret_version" "auth_cookie_name_version" {
  provider = google
  secret   = google_secret_manager_secret.auth_cookie_name.name
  version  = google_secret_manager_secret_version.auth_cookie_name_version.version
}

# create secret auth cookie signature key current
resource "google_secret_manager_secret" "auth_cookie_signature_key_current" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-auth-cookie-signature-key-current"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}

resource "google_secret_manager_secret_version" "auth_cookie_signature_key_current_version" {
  provider    = google
  secret      = google_secret_manager_secret.auth_cookie_signature_key_current.id
  secret_data = var.auth_cookie_signature_key_current
}

data "google_secret_manager_secret_version" "auth_cookie_signature_key_current_version" {
  provider = google
  secret   = google_secret_manager_secret.auth_cookie_signature_key_current.name
  version  = google_secret_manager_secret_version.auth_cookie_signature_key_current_version.version
}

# create secret auth cookie signature key current
resource "google_secret_manager_secret" "auth_cookie_signature_key_previous" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-auth-cookie-signature-key-previous"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}

resource "google_secret_manager_secret_version" "auth_cookie_signature_key_previous_version" {
  provider    = google
  secret      = google_secret_manager_secret.auth_cookie_signature_key_previous.id
  secret_data = var.auth_cookie_signature_key_previous
}

data "google_secret_manager_secret_version" "auth_cookie_signature_key_previous_version" {
  provider = google
  secret   = google_secret_manager_secret.auth_cookie_signature_key_previous.name
  version  = google_secret_manager_secret_version.auth_cookie_signature_key_previous_version.version
}

# create secret next public firebase api key
resource "google_secret_manager_secret" "next_public_firebase_api_key" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-next-public-firebase-api-key"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}

resource "google_secret_manager_secret_version" "next_public_firebase_api_key_version" {
  provider    = google
  secret      = google_secret_manager_secret.next_public_firebase_api_key.id
  secret_data = var.next_public_firebase_api_key
}

data "google_secret_manager_secret_version" "next_public_firebase_api_key_version" {
  provider = google
  secret   = google_secret_manager_secret.next_public_firebase_api_key.name
  version  = google_secret_manager_secret_version.next_public_firebase_api_key_version.version
}

# create secret next public firebase auth domain
resource "google_secret_manager_secret" "next_public_firebase_auth_domain" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-next-public-firebase-auth-domain"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}
resource "google_secret_manager_secret_version" "next_public_firebase_auth_domain_version" {
  provider    = google
  secret      = google_secret_manager_secret.next_public_firebase_auth_domain.id
  secret_data = var.next_public_firebase_auth_domain
}

data "google_secret_manager_secret_version" "next_public_firebase_auth_domain_version" {
  provider = google
  secret   = google_secret_manager_secret.next_public_firebase_auth_domain.name
  version  = google_secret_manager_secret_version.next_public_firebase_auth_domain_version.version
}

# create secret next public firebase project id
resource "google_secret_manager_secret" "next_public_firebase_project_id" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-next-public-firebase-project-id"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}
resource "google_secret_manager_secret_version" "next_public_firebase_project_id_version" {
  provider    = google
  secret      = google_secret_manager_secret.next_public_firebase_project_id.id
  secret_data = var.next_public_firebase_project_id
}

data "google_secret_manager_secret_version" "next_public_firebase_project_id_version" {
  provider = google
  secret   = google_secret_manager_secret.next_public_firebase_project_id.name
  version  = google_secret_manager_secret_version.next_public_firebase_project_id_version.version
}

# create secret next public firebase messaging sender id
resource "google_secret_manager_secret" "next_public_firebase_messaging_sender_id" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-next-public-firebase-messaging-sender-id"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}
resource "google_secret_manager_secret_version" "next_public_firebase_messaging_sender_id_version" {
  provider    = google
  secret      = google_secret_manager_secret.next_public_firebase_messaging_sender_id.id
  secret_data = var.next_public_firebase_messaging_sender_id
}

data "google_secret_manager_secret_version" "next_public_firebase_messaging_sender_id_version" {
  provider = google
  secret   = google_secret_manager_secret.next_public_firebase_messaging_sender_id.name
  version  = google_secret_manager_secret_version.next_public_firebase_messaging_sender_id_version.version
}


# create secret next public firebase storage bucket
resource "google_secret_manager_secret" "next_public_firebase_storage_bucket" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-next-public-firebase-storage-bucket"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}
resource "google_secret_manager_secret_version" "next_public_firebase_storage_bucket_version" {
  provider    = google
  secret      = google_secret_manager_secret.next_public_firebase_storage_bucket.id
  secret_data = var.next_public_firebase_storage_bucket
}

data "google_secret_manager_secret_version" "next_public_firebase_storage_bucket_version" {
  provider = google
  secret   = google_secret_manager_secret.next_public_firebase_storage_bucket.name
  version  = google_secret_manager_secret_version.next_public_firebase_storage_bucket_version.version
}

# create secret next public app id
resource "google_secret_manager_secret" "next_public_firebase_app_id" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-next-public-firebase-app-id"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}
resource "google_secret_manager_secret_version" "next_public_firebase_app_id_version" {
  provider    = google
  secret      = google_secret_manager_secret.next_public_firebase_app_id.id
  secret_data = var.next_public_firebase_app_id
}

data "google_secret_manager_secret_version" "next_public_firebase_app_id_version" {
  provider = google
  secret   = google_secret_manager_secret.next_public_firebase_app_id.name
  version  = google_secret_manager_secret_version.next_public_firebase_app_id_version.version
}

# create secret use secure cookies
resource "google_secret_manager_secret" "use_secure_cookies" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-use-secure-cookies"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}
resource "google_secret_manager_secret_version" "use_secure_cookies_version" {
  provider    = google
  secret      = google_secret_manager_secret.use_secure_cookies.id
  secret_data = var.use_secure_cookies
}

data "google_secret_manager_secret_version" "use_secure_cookies_version" {
  provider = google
  secret   = google_secret_manager_secret.use_secure_cookies.name
  version  = google_secret_manager_secret_version.use_secure_cookies_version.version
}
