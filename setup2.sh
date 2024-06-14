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

SERVICE_ACCOUNT="$PROJECT_ID-tf-sa"

echo $SERVICE_ACCOUNT

# Set project ID
# export PROJECT_ID="bluehaven-infra-modules"
# export SERVICE_ACCOUNT="$PROJECT_ID-tf-sa@$PROJECT_ID.iam.gserviceaccount.com"

# echo "$PROJECT_ID"
# echo "$SERVICE_ACCOUNT"

# Create policy.json with desired IAM bindings
# cat <<EOF > policy.json
# {
#   "bindings": [
#     {
#       "members": [
#         "serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com",
#         "user:marbildokaus@gmail.com"
#       ],
#       "role": "roles/iam.serviceAccountAdmin"
#     },
#     {
#       "members": [
#         "serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com",
#         "user:marbildokaus@gmail.com"
#       ],
#       "role": "roles/iam.serviceAccountTokenCreator"
#     }
#   ],
#   "etag": "ACAB"
# }
# EOF

# # set billing account on
# BILLING_ACCOUNT=$(gcloud beta billing accounts list --format="value(name)" | head -n 1)
# gcloud billing projects link $PROJECT_ID --billing-account="$BILLING_ACCOUNT"

# gsutil mb gs://$PROJECT_ID-tf-state
# gsutil versioning set on gs://$PROJECT_ID-tf-state

# echo "Script completed successfully."

# echo "{
#   \"bindings\": [
#     {
#       \"members\": [
#         \"serviceAccount:$SERVICE_ACCOUNT\",
#         \"user:marbildokaus@gmail.com\"
#       ],
#       \"role\": \"roles/iam.serviceAccountAdmin\"
#     },
#     {
#       \"members\": [
#         \"serviceAccount:$SERVICE_ACCOUNT\",
#         \"user:marbildokaus@gmail.com\"
#       ],
#       \"role\": \"roles/iam.serviceAccountTokenCreator\"
#     }
#   ],
#   \"etag\": \"ACAB\"
# }" > policy.json


# gcloud iam service-accounts set-iam-policy $SERVICE_ACCOUNT policy.json

# gsutil mb gs://bluehaven-infrastructure-setup-tf-state
# gsutil versioning set on gs://bluehaven-infrastructure-setup-tf-state

# echo "{
#   \"bindings\": [
#     {
#       \"members\": [
#         \"serviceAccount:$SERVICE_ACCOUNT\",
#         \"user:marbildokaus@gmail.com\"
#       ],
#       \"role\": \"roles/iam.serviceAccountAdmin\"
#     },
#     {
#       \"members\": [
#         \"serviceAccount:$SERVICE_ACCOUNT\",
#         \"user:marbildokaus@gmail.com\"
#       ],
#       \"role\": \"roles/iam.serviceAccountTokenCreator\"
#     }
#   ],
#   \"etag\": \"ACAB\"
# }" > policy.json

# echo "{\"bindings\":[{\"members\":[\"serviceAccount:$SERVICE_ACCOUNT\",\"user:marbildokaus@gmail.com\"],\"role\":\"roles/iam.serviceAccountAdmin\"},{\"members\":[\"serviceAccount:$SERVICE_ACCOUNT\",\"user:marbildokaus@gmail.com\"],\"role\":\"roles/iam.serviceAccountTokenCreator\"}],\"etag\":\"ACAB\"}" > policy.json
