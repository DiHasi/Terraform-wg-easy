data "http" "my_ip" {
  url = "https://api.ipify.org"
}

resource "docker_container" "wg_easy" {
  name  = "wg-easy"
  image = "ghcr.io/wg-easy/wg-easy:15"

  restart = "unless-stopped"

  ports {
    internal = 51820
    external = 51820
    protocol = "udp"
  }

  ports {
    internal = var.wg_internal_port
    external = var.wg_internal_port
    protocol = "tcp"
  }

  volumes {
    host_path      = pathexpand("~/.wg-easy")
    container_path = "/etc/wireguard"
  }

  volumes {
    host_path      = "/lib/modules"
    container_path = "/lib/modules"
    read_only      = true
  }

  capabilities {
    add = ["NET_ADMIN", "SYS_MODULE"]
  }

  sysctls = {
    "net.ipv4.ip_forward"              = "1"
    "net.ipv4.conf.all.src_valid_mark" = "1"
  }

  networks_advanced {
    name = docker_network.proxy.id
  }
}
