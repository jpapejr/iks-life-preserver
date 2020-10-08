provider "ibm" {
  ibmcloud_api_key = var.apikey
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

# data "ibm_resource_instance" "cluster_resource_instance" {
#   name              = var.cluster
#   location          = var.location
#   resource_group_id = data.ibm_resource_group.group.id
#   service           = "containers-kubernetes"
# }

resource "ibm_iam_user_invite" "invite_user" {
  users = [
    var.user
  ]

  iam_policy {
    roles = ["Viewer", "Reader"]
    resources {
      service              = "containers-kubernetes"
      resource_instance_id =  var.cluster
      attributes {
        namespace="kube-system"
      }
    }
  }

}

