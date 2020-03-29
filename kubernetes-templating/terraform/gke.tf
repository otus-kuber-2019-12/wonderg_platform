resource "google_project_service" "kubernetes" {
  service = "container.googleapis.com"
}

resource "google_container_cluster" "kubernetes" {
  name               = "otus-k8s-cluster"
  location           = "europe-north1"
  min_master_version = "1.15.9-gke.26"
  node_locations = [
    "europe-north1-a",
  ]

  depends_on               = [google_project_service.kubernetes]
  remove_default_node_pool = true
  initial_node_count       = 1


  master_auth {
    username = ""
    password = ""
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    tags = ["network-cluster"]
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "otus-nodes"
  location   = "europe-north1"
  cluster    = google_container_cluster.kubernetes.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
