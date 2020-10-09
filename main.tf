provider "ibm" {
  ibmcloud_api_key = var.apikey
}

resource "ibm_iam_service_id" "lifeperserver" {
  name = "life-preserver-id-${var.reference}"
}

resource "ibm_iam_service_policy" "life-preserver-policy" {
  depends_on = [ ibm_iam_service_id.lifeperserver ]
  iam_service_id = ibm_iam_service_id.lifeperserver.service_ids.id
  roles        = [ "Viewer", "Reader"]

  resources {
    service              = "containers-kubernetes"
    resource_instance_id = var.cluster
  }
}

resource "null_resource" "obtain-apikey" {
  provisioner "local-exec" {
    command = "ibmcloud iam service-api-key-create life-preserver life-preserver-id-${var.reference} -f"
  }
}


# resource "ibm_iam_user_policy" "policy" {
#   depends_on = [ ibm_iam_user_invite.invite_user ]
#   ibm_id = var.user
#   roles  = ["Viewer", "Reader"]
#   tags   = [ "life-preserver" ]
#   resources {
#     service              = "containers-kubernetes"
#     resource_instance_id = var.cluster
#   }
# }

