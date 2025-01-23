Cluster Role: Manages EKS control plane and networking resources.
Node Group Role: Allows worker nodes to join cluster and access basic AWS services.
OIDC IAM Role: Grants pods permissions (e.g., RDS, Redis) via service accounts.
aws_eks_access_entry: Maps IAM users/roles to Kubernetes groups for API access.
aws_eks_access_policy_association: Adds access policies for centralized cluster control.
aws_eks_identity_provider_config: Enables user login to EKS with an external OIDC provider.
aws_eks_pod_identity_association: Links Kubernetes service accounts to IAM roles for pod



Cluster Role: Lets cluster access aws
Node Group Role: lets nodegroup control ec2 nodes
OIDC IAM Role: iam role that pods can associate with to access aws resources (like rds, opensearch, redis)
aws_eks_access_entry: Links an IAM user or role to a Kubernetes group with specific permissions in EKS. For example, you could use this to add a developer’s IAM role to the read-only group, allowing them to view resources (like the notifications service) but not make changes.
aws_eks_access_policy_association: Applies cluster-wide access policies to manage user actions across all namespaces. For example, you could use this to enforce a policy that prevents specific users from creating or deleting pods, ensuring they have view-only permissions throughout the cluster, including the notifications service namespace.
aws_eks_identity_provider_config: External OIDC (but what does that mean or what can they access)
aws_eks_pod_identity_association: pod service account + OIDC IAM Role (needs addon)


Here’s the recommended order, from first to last, based on dependencies and setup flow:

Cluster Role: Required first to create and manage the EKS cluster and its control plane resources in AWS.

Node Group Role: Needed after the cluster is created to launch and manage the worker nodes in the node group.

OIDC IAM Role: Set up the IAM role for service accounts with permissions for accessing AWS resources. This role will be associated with pods later.

aws_iam_openid_connect_provider: Register the OIDC provider in IAM for your EKS cluster. This step enables Kubernetes service accounts to assume IAM roles.

aws_eks_pod_identity_association: Associate a Kubernetes service account with the OIDC IAM Role, allowing specific pods to access AWS resources (e.g., RDS or Redis).

aws_eks_access_entry: Map IAM users or roles to Kubernetes groups within EKS, providing developers or administrators with the correct access to cluster resources.

aws_eks_access_policy_association: Set up policies for managing actions across the cluster, controlling permissions such as who can create or delete resources.

aws_eks_identity_provider_config (if using external OIDC): Configure this last, as it depends on the cluster being set up. This enables user login through an external identity provider like Okta.