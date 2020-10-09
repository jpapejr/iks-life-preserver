provider "ibm" {
  ibmcloud_api_key = var.apikey
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

resource "ibm_iam_user_invite" "invite_user" {
  users = [
    var.user
  ]

  # iam_policy {
  #   roles = ["Viewer", "Reader"]
  #   resources {
  #     service              = "containers-kubernetes"
  #     resource_instance_id =  var.cluster
  #   }
  # }

}


resource "ibm_iam_user_policy" "policy" {
  ibm_id = var.user
  roles  = ["Viewer", "Reader"]
  tags   = [ "life-preserver" ]
  resources {
    service              = "containers-kubernetes"
    resource_instance_id = var.cluster
  }
}

