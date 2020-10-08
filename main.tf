provider "ibm" {
}

resource "ibm_iam_access_group" "accgrp" {
  name        = "test"
  description = "New access group"
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

resource "ibm_iam_user_invite" "invite_user" {
  users = [
    var.user
  ]

  iam_policy {
    roles = ["Viewer"]
    resources {
      name              = var.cluster
      service           = "containers-kubernetes"
      resource_group_id = data.ibm_resource_group.group.id
    }
  }

}

resource "ibm_iam_user_settings" "user_setting" {
  iam_id = var.user
}
