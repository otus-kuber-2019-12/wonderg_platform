provider "google" {
  credentials = "${file("~/.gcp/otus-268421-1e09bdfb000b.json")}"
  project     = "otus-268421"
  region      = "europe-north1"
}
