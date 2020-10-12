provider "ibm" {
  ibmcloud_api_key = var.apikey
}

resource "ibm_iam_service_id" "lifeperserver" {
  name = "life-preserver-id-${var.reference}"
}

resource "ibm_iam_service_policy" "life-preserver-policy" {
  depends_on = [ ibm_iam_service_id.lifeperserver ]
  iam_service_id = ibm_iam_service_id.lifeperserver.id
  roles        = [ "Viewer", "Reader"]

  resources {
    service              = "containers-kubernetes"
    resource_instance_id = var.cluster
  }
}

resource "null_resource" "cli-login" {
  provisioner "local-exec" {
    command = <<EOT
    ibmcloud login -a cloud.ibm.com --apikey ${var.apikey} -c ${var.account} -r us-south
  EOT
  }
}

data "external" "apikey" {
  depends_on = [ null_resource.cli-login ]
  program = ["ibmcloud",   "iam", "service-api-key-create", "life-preserver", "life-preserver-id-${var.reference}", "--output", "json"]
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

