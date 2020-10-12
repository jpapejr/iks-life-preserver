variable "user" {
    description = "The user name of the user to invite to the account"
}

variable "cluster" { 
    description = "The cluster ID of the target cluster"
}

variable "apikey" {
    description = "An IBM Cloud API Key with permission to invite users to the account"
}

variable "reference" {
    description = "A reference tag/string of your choosing"
}

variable "account" {
    description = "The IBM Cloud account ID to use"
}