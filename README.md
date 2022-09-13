# deep-racer-event-setup

Repository to set-up your own deep racer multi-user event

![aws-deep-racer](source/deepracer.png)

## Instructions for use

Navigate to variables.tf: -
 - populate 'subscriber_email_addresses' var with the email address of people you'd like to receive AWS budget alerts
 - populate 'deep_racer_participants' with the usernames of the people you'd like to participate in your AWS Deep Racer event
 - optionally amend 'billing_alert_price' and 'billing_alert_unit' to reflect your needs

Deploy code using Terraform: -
 - Install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your OS of choice
 - Navigate within your terminal to this folder
 - run 'terraform init'
 - run 'terraform plan'
 - run 'terraform apply'
 - Navigate via the AWS Console to the Deep Racer Console and use multi-user management setup area via instructions [here](https://docs.aws.amazon.com/deepracer/latest/developerguide/deepracer-multi-user-admin-set-up.html)
 - Every user in 'deep_racer_participants' var will have their username and passwords added into 'users_and_passwords.csv' within this directory

If you want to set-up your own private deep racer event please see instructions [here](https://docs.aws.amazon.com/deepracer/latest/developerguide/deepracer-create-community-race.html)

## Requirements

Terraform

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.30.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.aws_billing_alert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |
| [aws_iam_group.deep_racer_participants](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.deep_racer_participants](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.deep_racer_participants2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.deep_racer_participants3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.s3_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.deep_racer_participant](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.deep_racer_participant](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_login_profile.deep_racer_participant](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile) | resource |
| [aws_s3_bucket.models](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.models](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [null_resource.users_passwords](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.user_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Name of the AWS region to deploy to.  Deep Racer currently only supported in us-east-1 | `string` | `"us-east-1"` | no |
| <a name="input_billing_alert_price"></a> [billing\_alert\_price](#input\_billing\_alert\_price) | The limit alert for billing alerts | `list(any)` | <pre>[<br>  "1000",<br>  "2000",<br>  "3000",<br>  "4000",<br>  "5000"<br>]</pre> | no |
| <a name="input_billing_alert_unit"></a> [billing\_alert\_unit](#input\_billing\_alert\_unit) | The unit of measurement for the budget forecast | `string` | `"USD"` | no |
| <a name="input_deep_racer_participants"></a> [deep\_racer\_participants](#input\_deep\_racer\_participants) | List of Deep Racer Participant IAM users to create | `set(string)` | `[]` | no |
| <a name="input_deployment_tool"></a> [deployment\_tool](#input\_deployment\_tool) | Tool used to deploy code | `string` | `"terraform"` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Name of the GitHub Repository. | `string` | `"deep-racer-event-setup"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service | `string` | `"Deep Racer"` | no |
| <a name="input_subscriber_email_addresses"></a> [subscriber\_email\_addresses](#input\_subscriber\_email\_addresses) | The email addresses to notify | `list(any)` | `[]` | no |

## Outputs

No outputs.