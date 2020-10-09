provider "ibm" {
  ibmcloud_api_key = var.apikey
}

resource "ibm_iam_user_invite" "invite_user" {
  users = [
    var.user
  ]
}


resource "ibm_iam_user_policy" "policy" {
  depends_on = [ ibm_iam_user_invite.invite_user ]
  ibm_id = var.user
  roles  = ["Viewer", "Reader"]
  tags   = [ "life-preserver" ]
  resources {
    service              = "containers-kubernetes"
    resource_instance_id = var.cluster
  }
}

