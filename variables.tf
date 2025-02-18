variable "compartment_ocid" {}
variable "region" {}
variable "tenancy" {}
variable "fingerprint" {}
variable "user" {}
variable "image_ocid" {
  default = "ocid1.image.oc1.sa-bogota-1.aaaaaaaaq36i27jvareldpe2r4v4sfsybisehkrcyfipxolh5kfpt7k4ysca"
}
variable "my-shape" {
  default = "VM.Standard.E4.Flex"
}

variable "ocpu" {
  default = "2"
}

variable "mem" {
  default = "32"
}

####