module "vpc_network" {
  source = "./modules/vpc_network"
  network_name = var.network_name
  subnet_name = var.subnet_name
  project_id = var.project_id
  region = var.region
}

module "cloud_build_trigger_01" {
  source = "./modules/cloud-build_w_wp"

  cb_repo_name        = var.cb_repo_name
  cb_repo_type        = var.cb_repo_type
  cb_region           = var.region
  cb_trigger_name     = var.cb_trigger_name
  cb_filename         = var.cb_filename
  project_id       = var.project_id
  workerpool_name  = var.workerpool_name
  wp_disk_size     = var.wp_disk_size
  network          = module.vpc_network.network_id
  no_external_ip   = var.no_external_ip

  depends_on = [module.vpc_network]
}

module "linux_vm" {
  source = "./modules/linux instance"
  vm_name = "target-vm"
  project = var.project_id
  network_name = module.vpc_network.network_name
  subnet_name = module.vpc_network.subnet_name[0]
  depends_on = [ module.vpc_network ]
}