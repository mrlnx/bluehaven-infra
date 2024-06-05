#!/bin/bash

set -e

# Initialize variables
PROJECT_ID=""

# Help function
print_help() {
    echo "Usage: $0 --project=<project>"
    echo
    echo "Options:"
    echo "  --project=<project>  Specify the project name"
    echo "  -h, --help           Show this help message"
}

# Parse command-line options
if [[ "$#" -eq 0 ]]; then
    print_help
    exit 1
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --project=*) PROJECT_ID="${1#*=}"; shift ;;
        -h|--help) print_help; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; print_help; exit 1 ;;
    esac
done

# Check if project variable is set
if [ -z "$PROJECT_ID" ]; then
    echo "Error: --project argument is required."
    print_help
    exit 1
fi

# Set project ID
SERVICE_ACCOUNT="$PROJECT_ID-tf-sa@$PROJECT_ID.iam.gserviceaccount.com"

# Create a new project
gcloud projects create "$PROJECT_ID"

# Authenticate gcloud
gcloud auth application-default login

# Set the newly created project as the default
gcloud config set project "$PROJECT_ID"

# Display the current configuration
gcloud config list

# Create a service account
gcloud iam service-accounts create "$PROJECT_ID-tf-sa" \
  --display-name="Infrastructure Service Account"

# Add roles to the service account
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT" \
  --role="roles/editor"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT" \
  --role="roles/iam.serviceAccountTokenCreator"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT" \
  --role="roles/resourcemanager.projectIamAdmin"


gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT" \
  --role="roles/iam.serviceAccountUser"

# Create policy.json with desired IAM bindings
cat <<EOF > policy.json
{
  "bindings": [
    {
      "members": [
        "serviceAccount:$SERVICE_ACCOUNT",
        "user:marbildokaus@gmail.com"
      ],
      "role": "roles/iam.serviceAccountAdmin"
    },
    {
      "members": [
        "serviceAccount:$SERVICE_ACCOUNT",
        "user:marbildokaus@gmail.com"
      ],
      "role": "roles/iam.serviceAccountTokenCreator"
    }
  ],
  "etag": "ACAB"
}
EOF

# create policy
gcloud iam service-accounts set-iam-policy "$SERVICE_ACCOUNT" policy.json

# set billing account on
BILLING_ACCOUNT=$(gcloud beta billing accounts list --format="value(name)" | head -n 1)

if [ -z "$BILLING_ACCOUNT" ]; then
  echo "No billing account found. Please ensure you have a billing account set up."
  exit 1
fi

gcloud billing projects link "$PROJECT_ID" --billing-account="$BILLING_ACCOUNT"

# create bucket in storage
gsutil mb gs://$PROJECT_ID-tf-state
gsutil versioning set on gs://$PROJECT_ID-tf-state

# enable services
gcloud services enable iamcredentials.googleapis.com \
    compute.googleapis.com \
    storage.googleapis.com \
    sqladmin.googleapis.com \
    servicenetworking.googleapis.com \
    run.googleapis.com \
    cloudbuild.googleapis.com \
    iam.googleapis.com

echo "Project: $PROJECT_ID"
echo "Service account: $SERVICE_ACCOUNT"

echo "Create $PROJECT_ID.backend"

cat <<EOF > setup.backend
bucket                      = "$PROJECT_ID-tf-state"
prefix                      = "static.tfstate.d"
impersonate_service_account = "$SERVICE_ACCOUNT"
EOF

echo "Create $PROJECT_ID.tfvars"

PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")

cat <<EOF > setup.tfvars
project_id                               = "$PROJECT_ID"
project_number                           = "$PROJECT_NUMBER"
tf_service_account                       = "$SERVICE_ACCOUNT"
region                                   = "europe-west4"
zone                                     = "europe-west4-a"
EOF

gcloud auth application-default login --project "$PROJECT_ID"

rm -rf ./policy.json

echo "Script completed successfully."