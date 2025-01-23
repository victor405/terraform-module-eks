# eks-cluster



## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/platform/terraform/resources/aws/eks-cluster.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.com/platform/terraform/resources/aws/eks-cluster/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Set auto-merge](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thanks to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README

Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_access_entry.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_entry) | resource |
| [aws_eks_access_policy_association.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_policy_association) | resource |
| [aws_eks_addon.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_fargate_profile.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_fargate_profile) | resource |
| [aws_eks_identity_provider_config.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_identity_provider_config) | resource |
| [aws_eks_node_group.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_eks_pod_identity_association.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_pod_identity_association) | resource |
| [aws_iam_role.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_node_group_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.fargate_pod_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_cluster_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_node_group_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_vpc_resource_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.fargate_pod_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.eks_cluster_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.eks_cluster_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policy_associations"></a> [access\_policy\_associations](#input\_access\_policy\_associations) | Map of EKS access policy associations | <pre>map(object({<br>    policy_arn     = string<br>    principal_arn  = string<br>    access_scope = object({<br>      type       = string<br>      namespaces = list(string)<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_addons"></a> [addons](#input\_addons) | Map of EKS addons with their configurations | <pre>map(object({<br>    addon_version               = string<br>    configuration_values        = string<br>    resolve_conflicts_on_create = string<br>    resolve_conflicts_on_update = string<br>    preserve                    = bool<br>    service_account_role_arn    = string<br>    tags                        = map(string)<br>  }))</pre> | `{}` | no |
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | Type of Amazon Machine Image (AMI) associated with the EKS Node Group | `any` | `null` | no |
| <a name="input_authentication_mode"></a> [authentication\_mode](#input\_authentication\_mode) | Authentication mode for the cluster | `string` | `"CONFIG_MAP"` | no |
| <a name="input_bootstrap_cluster_creator_admin_permissions"></a> [bootstrap\_cluster\_creator\_admin\_permissions](#input\_bootstrap\_cluster\_creator\_admin\_permissions) | Bootstrap admin permissions for cluster creator | `bool` | `true` | no |
| <a name="input_bootstrap_self_managed_addons"></a> [bootstrap\_self\_managed\_addons](#input\_bootstrap\_self\_managed\_addons) | Install default unmanaged add-ons during cluster creation | `bool` | `true` | no |
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | Type of capacity associated with the EKS Node Group (ON\_DEMAND or SPOT) | `string` | `"ON_DEMAND"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `any` | `null` | no |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Desired number of worker nodes | `number` | `1` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size in GiB for worker nodes | `any` | `null` | no |
| <a name="input_eks_access_entries"></a> [eks\_access\_entries](#input\_eks\_access\_entries) | Map of EKS access entries with specific configurations | <pre>map(object({<br>    principal_arn     = string<br>    kubernetes_groups = list(string)<br>    type              = string<br>    user_name         = string<br>    tags              = map(string)<br>  }))</pre> | `{}` | no |
| <a name="input_eks_cluster_tags"></a> [eks\_cluster\_tags](#input\_eks\_cluster\_tags) | Tags for the EKS cluster | `any` | `null` | no |
| <a name="input_enabled_cluster_log_types"></a> [enabled\_cluster\_log\_types](#input\_enabled\_cluster\_log\_types) | List of control plane log types to enable | `list` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| <a name="input_encryption_config"></a> [encryption\_config](#input\_encryption\_config) | Encryption configuration for the cluster, including provider KMS key ARN and resources to encrypt. | <pre>list(object({<br>    cluster_encryption_config_kms_key = optional(string)<br>    cluster_encryption_config         = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "cluster_encryption_config": [<br>      "secrets"<br>    ],<br>    "cluster_encryption_config_kms_key": ""<br>  }<br>]</pre> | no |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | Enable private access to the EKS cluster endpoint | `bool` | `true` | no |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | Enable public access to the EKS cluster endpoint | `bool` | `false` | no |
| <a name="input_fargate_profile_enabled"></a> [fargate\_profile\_enabled](#input\_fargate\_profile\_enabled) | Enable EKS Fargate Profile | `any` | n/a | yes |
| <a name="input_fargate_profile_tags"></a> [fargate\_profile\_tags](#input\_fargate\_profile\_tags) | Key-value map of resource tags | `map` | `{}` | no |
| <a name="input_force_update_version"></a> [force\_update\_version](#input\_force\_update\_version) | Force version update if existing pods are unable to be drained | `any` | `null` | no |
| <a name="input_identity_providers"></a> [identity\_providers](#input\_identity\_providers) | Map of OIDC identity provider configurations | <pre>map(object({<br>    client_id                     = string<br>    identity_provider_config_name = string<br>    issuer_url                    = string<br>    groups_claim                  = string<br>    groups_prefix                 = string<br>    required_claims               = map(string)<br>    username_claim                = string<br>    username_prefix               = string<br>    tags                          = map(string)<br>  }))</pre> | `{}` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | List of instance types associated with the EKS Node Group | `list` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version for the EKS cluster | `any` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Key-value map of Kubernetes labels | `map` | `{}` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of worker nodes | `number` | `2` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of worker nodes | `number` | `1` | no |
| <a name="input_network_config"></a> [network\_config](#input\_network\_config) | List of network configuration settings for Kubernetes network config, including IP family and service IPv4 CIDR. | <pre>list(object({<br>    ip_family         = string<br>    service_ipv4_cidr = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_node_group_enabled"></a> [node\_group\_enabled](#input\_node\_group\_enabled) | Enable EKS Node Group | `bool` | `true` | no |
| <a name="input_node_group_tags"></a> [node\_group\_tags](#input\_node\_group\_tags) | Key-value map of resource tags | `map` | `{}` | no |
| <a name="input_outpost_config"></a> [outpost\_config](#input\_outpost\_config) | List of Outpost configuration settings, including control plane instance type, Outpost ARNs, and control plane placement group name. | <pre>list(object({<br>    control_plane_instance_type      = string<br>    outpost_arns                     = list(string)<br>    control_plane_placement_group_name = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_pod_identity_associations"></a> [pod\_identity\_associations](#input\_pod\_identity\_associations) | Map of EKS pod identity associations | <pre>map(object({<br>    namespace       = string<br>    service_account = string<br>    role_arn        = string<br>    tags            = map(string)<br>  }))</pre> | `{}` | no |
| <a name="input_public_access_cidrs"></a> [public\_access\_cidrs](#input\_public\_access\_cidrs) | List of CIDR blocks for public access | `list` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_release_version"></a> [release\_version](#input\_release\_version) | AMI version of the EKS Node Group | `any` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs for the EKS cluster | `any` | `null` | no |
| <a name="input_selectors"></a> [selectors](#input\_selectors) | List of selectors for the Fargate Profile | `any` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the EKS cluster | `list` | <pre>[<br>  "subnet-05f6f778269385a68",<br>  "subnet-092ae8d4abf4a454c"<br>]</pre> | no |
| <a name="input_update_policy"></a> [update\_policy](#input\_update\_policy) | List of update policies for EKS cluster, including support type for upgrade policy. | <pre>list(object({<br>    support_type = string<br>  }))</pre> | <pre>[<br>  "STANDARD"<br>]</pre> | no |
| <a name="input_zonal_shift_config"></a> [zonal\_shift\_config](#input\_zonal\_shift\_config) | Configuration for enabling zonal shift, with an enabled flag. | <pre>list(object({<br>    enabled = bool<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The ARN of the EKS cluster. |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with your cluster. |
| <a name="output_cluster_created_at"></a> [cluster\_created\_at](#output\_cluster\_created\_at) | Unix epoch timestamp in seconds for when the cluster was created. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The endpoint for your Kubernetes API server. |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The name of the EKS cluster. |
| <a name="output_cluster_identity_oidc_issuer"></a> [cluster\_identity\_oidc\_issuer](#output\_cluster\_identity\_oidc\_issuer) | Issuer URL for the OpenID Connect identity provider. |
| <a name="output_cluster_platform_version"></a> [cluster\_platform\_version](#output\_cluster\_platform\_version) | Platform version for the cluster. |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Cluster security group created by Amazon EKS for the cluster. |
| <a name="output_cluster_service_ipv6_cidr"></a> [cluster\_service\_ipv6\_cidr](#output\_cluster\_service\_ipv6\_cidr) | The CIDR block that Kubernetes pod and service IP addresses are assigned from if IPv6 is used. |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | The status of the EKS cluster. |
| <a name="output_cluster_tags_all"></a> [cluster\_tags\_all](#output\_cluster\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The Kubernetes server version for the EKS cluster. |
| <a name="output_cluster_vpc_id"></a> [cluster\_vpc\_id](#output\_cluster\_vpc\_id) | ID of the VPC associated with your cluster. |
| <a name="output_eks_access_entry_arns"></a> [eks\_access\_entry\_arns](#output\_eks\_access\_entry\_arns) | Amazon Resource Name (ARN) of the Access Entry. |
| <a name="output_eks_access_entry_created_at"></a> [eks\_access\_entry\_created\_at](#output\_eks\_access\_entry\_created\_at) | Date and time in RFC3339 format that the EKS add-on was created. |
| <a name="output_eks_access_entry_modified_at"></a> [eks\_access\_entry\_modified\_at](#output\_eks\_access\_entry\_modified\_at) | Date and time in RFC3339 format that the EKS add-on was updated. |
| <a name="output_eks_access_entry_tags_all"></a> [eks\_access\_entry\_tags\_all](#output\_eks\_access\_entry\_tags\_all) | Key-value map of resource tags, including those inherited from the provider default\_tags configuration block. |
| <a name="output_eks_addon_arns"></a> [eks\_addon\_arns](#output\_eks\_addon\_arns) | Amazon Resource Name (ARN) of the EKS add-on. |
| <a name="output_eks_addon_created_at"></a> [eks\_addon\_created\_at](#output\_eks\_addon\_created\_at) | Date and time in RFC3339 format that the EKS add-on was created. |
| <a name="output_eks_addon_ids"></a> [eks\_addon\_ids](#output\_eks\_addon\_ids) | EKS Cluster name and EKS Addon name separated by a colon (:). |
| <a name="output_eks_addon_modified_at"></a> [eks\_addon\_modified\_at](#output\_eks\_addon\_modified\_at) | Date and time in RFC3339 format that the EKS add-on was updated. |
| <a name="output_eks_addon_statuses"></a> [eks\_addon\_statuses](#output\_eks\_addon\_statuses) | Status of the EKS add-on. |
| <a name="output_eks_addon_tags_all"></a> [eks\_addon\_tags\_all](#output\_eks\_addon\_tags\_all) | Key-value map of resource tags, including those inherited from the provider default\_tags configuration block. |
| <a name="output_eks_associated_access_policies"></a> [eks\_associated\_access\_policies](#output\_eks\_associated\_access\_policies) | Contains information about the access policy association. |
| <a name="output_eks_associated_access_policy_associated_at"></a> [eks\_associated\_access\_policy\_associated\_at](#output\_eks\_associated\_access\_policy\_associated\_at) | Date and time in RFC3339 format that the policy was associated. |
| <a name="output_eks_associated_access_policy_modified_at"></a> [eks\_associated\_access\_policy\_modified\_at](#output\_eks\_associated\_access\_policy\_modified\_at) | Date and time in RFC3339 format that the policy was updated. |
| <a name="output_eks_fargate_profile_arn"></a> [eks\_fargate\_profile\_arn](#output\_eks\_fargate\_profile\_arn) | Amazon Resource Name (ARN) of the EKS Fargate Profile. |
| <a name="output_eks_fargate_profile_id"></a> [eks\_fargate\_profile\_id](#output\_eks\_fargate\_profile\_id) | EKS Cluster name and EKS Fargate Profile name separated by a colon (:). |
| <a name="output_eks_fargate_profile_status"></a> [eks\_fargate\_profile\_status](#output\_eks\_fargate\_profile\_status) | Status of the EKS Fargate Profile. |
| <a name="output_eks_fargate_profile_tags_all"></a> [eks\_fargate\_profile\_tags\_all](#output\_eks\_fargate\_profile\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_eks_identity_provider_arns"></a> [eks\_identity\_provider\_arns](#output\_eks\_identity\_provider\_arns) | ARN of the EKS Identity Provider Configuration. |
| <a name="output_eks_identity_provider_ids"></a> [eks\_identity\_provider\_ids](#output\_eks\_identity\_provider\_ids) | EKS Cluster name and EKS Identity Provider Configuration name separated by a colon (:). |
| <a name="output_eks_identity_provider_statuses"></a> [eks\_identity\_provider\_statuses](#output\_eks\_identity\_provider\_statuses) | Status of the EKS Identity Provider Configuration. |
| <a name="output_eks_identity_provider_tags_all"></a> [eks\_identity\_provider\_tags\_all](#output\_eks\_identity\_provider\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_eks_node_group_arn"></a> [eks\_node\_group\_arn](#output\_eks\_node\_group\_arn) | Amazon Resource Name (ARN) of the EKS Node Group. |
| <a name="output_eks_node_group_id"></a> [eks\_node\_group\_id](#output\_eks\_node\_group\_id) | EKS Cluster name and EKS Node Group name separated by a colon (:). |
| <a name="output_eks_node_group_resources"></a> [eks\_node\_group\_resources](#output\_eks\_node\_group\_resources) | List of objects containing information about underlying resources. |
| <a name="output_eks_node_group_status"></a> [eks\_node\_group\_status](#output\_eks\_node\_group\_status) | Status of the EKS Node Group. |
| <a name="output_eks_node_group_tags_all"></a> [eks\_node\_group\_tags\_all](#output\_eks\_node\_group\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_eks_pod_identity_association_arns"></a> [eks\_pod\_identity\_association\_arns](#output\_eks\_pod\_identity\_association\_arns) | The Amazon Resource Name (ARN) of the association. |
| <a name="output_eks_pod_identity_association_ids"></a> [eks\_pod\_identity\_association\_ids](#output\_eks\_pod\_identity\_association\_ids) | The ID of the association. |
| <a name="output_eks_pod_identity_association_tags_all"></a> [eks\_pod\_identity\_association\_tags\_all](#output\_eks\_pod\_identity\_association\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
<!-- END_TF_DOCS -->