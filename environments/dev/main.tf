# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


locals {
  env = "dev"
}

provider "google" {
  project = "${var.project}"
}

module "vpc" {
  source  = "../../modules/vpc"
  project = "${var.project}"
  env     = "${local.env}"
}

module "firewall" {
  source  = "../../modules/firewall"
  project = "${var.project}"
  subnet  = "${module.vpc.subnet[0]}"
  network = "${local.env}"
}

module "http_server" {
  source  = "../../modules/http_server"
  project = "${var.project}"
  subnet  = "${module.vpc.subnet[0]}"
  network = "${local.env}"
}

/*module "gke" {
  source  = "../../modules/gke"
  project = "${var.project}"
  subnet  = "${module.vpc.subnet}"
  env     = "${local.env}"
} 

 module "cluster-1" {
  source = "../../modules/gke-cluster"
  project_id                = "${var.project}"
  name                      = "cluster-1"
  location                  = "us-west1-a"
  network                   = var.network_self_link
  subnetwork                = var.subnet_self_link
  secondary_range_pods      = "pods"
  secondary_range_services  = "services"
  default_max_pods_per_node = 32
  master_authorized_ranges = {
    internal-vms = "10.0.0.0/8"
  }
  private_cluster_config = {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "192.168.0.0/28"
  }
  labels = {
    environment = "${local.env}"
  }
}

module "cluster-1-nodepool-1" {
  source                      = "../../modules/gke-nodepool"
  project_id                  = "${var.project}"
  cluster_name                = "cluster-1"
  location                    = "us-west1-a"
  name                        = "nodepool-1"
} */
