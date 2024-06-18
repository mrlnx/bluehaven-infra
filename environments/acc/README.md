# Bluehaven infrastructure

1. Create first a service account => with the name

```
gcloud iam service-accounts create bluehaven-infrastructure-setup --display-name="Bluehaven Infra Test Service Account"
```

2. When applying to a new project change values .backend file. with this name

gcloud projects add-iam-policy-binding bluehaven-infrastructure-setup--member="serviceAccount:bluehaven-infrastructure-setup-tf-sa@bluehaven-infrastructure-setup.iam.gserviceaccount.com" --role="roles/iam.serviceAccountTokenCreator"

- bucket => should match with bucket in cloudstorage
  ```
  gsutil mb -l gs://<bucket_name>-tf-state
  gsutil versioning set on gs://<bucket_name>-tf-state
  ```
- impersonate_service_account => should be a sa which exists with correct permissions
- variables update
- policy of the service account should be equal to the policy.json > need to check the permissions again.

### Problems which can occur

1. <strong>No permission for project</strong>
2. Api services not enabled
3. when creating new policy binding the owner should also be added see policy_new.json

https://gcloud.devoteam.com/blog/a-step-by-step-guide-to-set-up-a-gcp-project-to-start-using-terraform/

### Importing modules

```
terraform import module.backend_service_db.google_compute_global_address.private_postgres_ip_address projects/bluehaven-infra-env/global/addresses/cloud-private-ip-address
```
