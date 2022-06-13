resource "yandex_compute_instance" "nat_instance" {
    name            = "nat-instance"
    zone            = var.ZONE

    resources {
        cores           = 2
        memory          = 1
        core_fraction   = 20
    }

    boot_disk {
        initialize_params {
            image_id    = "fd80mrhj8fl2oe87o4e1"
        }
    }

    network_interface {
        subnet_id       = "${yandex_vpc_subnet.subnets["public"].id}"
        nat_ip_address  = "192.168.10.254" 
    }
}


resource "yandex_compute_instance" "tmp_vm" {
    for_each    = {for tmp in var.TMP_VMS : tmp.name => tmp if tmp.count > 0 }

    name        = "${each.value.name}"
    zone        = var.ZONE

    metadata = {
        ssh-keys= "${each.value.user_name}:${file("~/.ssh/id_rsa.pub")}"
    }

    resources {
        cores           = "${each.value.cpu}"
        memory          = "${each.value.ram}"
        core_fraction   = 20  
    }

    boot_disk {
        initialize_params {
            image_id    = "${each.value.image_id}"
        }
    }

     network_interface {
        subnet_id       = "${yandex_vpc_subnet.subnets["${each.value.subnet_name}"].id}"
        nat             = "${each.value.nat}"
    }
}


resource "yandex_iam_service_account" "sa" {
  name      = "s3-bucket-sa"
  folder_id = var.FOLDER
}

resource "yandex_resourcemanager_folder_iam_member" "sa_iam" {
    for_each    = {for iam in local.sa_iam : iam.role => iam}

    role        = "${each.value.role}"
    member      = "serviceAccount:${each.value.sa_id}"
    folder_id   = var.FOLDER
}

resource "yandex_iam_service_account_static_access_key" "s3-bucket-sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
}

resource "yandex_storage_bucket" "s3" {
  access_key = yandex_iam_service_account_static_access_key.s3-bucket-sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3-bucket-sa-static-key.secret_key
  bucket = "s3-terraform-test-bucket"
}

resource "yandex_compute_instance_group" "lamp_group" {

    name                    = "${local.lamp_template.group_name}"
    folder_id               = var.FOLDER
    service_account_id      = "${yandex_iam_service_account.sa.id}"

    instance_template {
        resources {
            memory          = "${local.lamp_template.vm.ram}"
            cores           = "${local.lamp_template.vm.cpu}"
            core_fraction   = 20
        }

        boot_disk {
            initialize_params {
                image_id    = "${local.lamp_template.vm.image_id}"
            }
        }

        network_interface {
            subnet_ids      = ["${yandex_vpc_subnet.subnets["${local.lamp_template.vm.subnet_name}"].id}"]
            network_id      = "${yandex_vpc_network.block-15.id}"
            nat             = "${local.lamp_template.vm.nat}"
        }

        metadata = {
            ssh-keys        = "${local.lamp_template.vm.user_name}:${file("~/.ssh/id_rsa.pub")}"
            user-data       = <<EOF
#!/bin/bash
apt install httpd -y
cd /var/www/html
sudo chown -R ubuntu:ubuntu /var/www/html
echo '<html><img src="https://storage.yandexcloud.net/s3-terraform-test-bucket/bucket-test-image.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEeSkfQMgOsXjKaR3-PZAa%2F20220613%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20220613T105852Z&X-Amz-Expires=86400&X-Amz-Signature=39437ED22353F4D19BAF5781A54B50D78927E05D5EC99AEF9F1C517EB7AABDE2&X-Amz-SignedHeaders=host"/></html>' > index.html
service httpd start
EOF          
        }
    } 

    scale_policy {
        fixed_scale {
            size    = "${local.lamp_template.scale_size}"
        }
    }

    deploy_policy {
        max_creating    = "${local.lamp_template.max_creating}"
        max_expansion   = "${local.lamp_template.max_expansion}"
        max_deleting    = "${local.lamp_template.max_deleting}"
        max_unavailable = "${local.lamp_template.max_unavailable}"
    }

    allocation_policy {
        zones   = [var.ZONE]
    }

    load_balancer {
        target_group_name   = "${local.lamp_template.group_name}"
    }

    health_check {
        http_options {
            port    = 80
            path    = "/"
        }
    }

    depends_on = [
        yandex_iam_service_account.sa,
        yandex_storage_bucket.s3,
        yandex_vpc_network.block-15,
        yandex_vpc_subnet.subnets,
        yandex_resourcemanager_folder_iam_member.sa_iam
    ]
}