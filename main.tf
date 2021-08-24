provider "google" {
  project = "csm-artifactory"
  region = "us-central1"
  zone = "us-central1-a"
}


resource "google_compute_instance" "sles-rmt-1" {
  name = "sles-rmt-1"
  description = "SLES RMT server to mirror SLES RPM repos."
  machine_type = "e2-medium"
  tags = [
    "http-server",
    "https-server",
  ]
  boot_disk {
    auto_delete = true
    device_name = "sles-rmt-1"
    mode = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/csm-artifactory/zones/us-central1-a/disks/sles-rmt-1"

    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/suse-cloud/global/images/sles-15-sp3-v20210727"
      labels = {}
      size = 20
      type = "pd-balanced"
    }
  }
  attached_disk {
    device_name = "persistent-disk-1"
    mode = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/csm-artifactory/zones/us-central1-a/disks/sles-rmt-1-1"
  }
  network_interface {
    network = "https://www.googleapis.com/compute/v1/projects/csm-artifactory/global/networks/main-vpc"
    network_ip = "10.0.0.8"
    subnetwork = "https://www.googleapis.com/compute/v1/projects/csm-artifactory/regions/us-central1/subnetworks/main-vpc-private-1"
    subnetwork_project = "csm-artifactory"
  }
}