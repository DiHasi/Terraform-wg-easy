resource "docker_volume" "caddy_data" {
  name = "caddy_data"
}

resource "docker_volume" "caddy_config" {
  name = "caddy_config"
}

resource "docker_container" "caddy" {
  name  = "caddy"
  image = "caddy:latest"

  restart = "unless-stopped"

  ports {
    internal = 80
    external = 80
    protocol = "tcp"
  }

  ports {
    internal = 443
    external = 443
    protocol = "tcp"
  }

  ports {
    internal = 443
    external = 443
    protocol = "udp"
  }

  volumes {
    host_path      = "/var/run/caddy"
    container_path = "/run/caddy"
  }

  volumes {
    host_path      = abspath("${path.module}/conf")
    container_path = "/etc/caddy"
  }

  volumes {
    host_path      = abspath("${path.module}/site")
    container_path = "/srv"
  }

  volumes {
    volume_name    = docker_volume.caddy_data.name
    container_path = "/data"
  }

  volumes {
    volume_name    = docker_volume.caddy_config.name
    container_path = "/config"
  }

  networks_advanced {
    name = docker_network.proxy.id
  }
}

data "caddy_server_route" "wg_route" {
  match {
    host = [var.domain]
  }

  handle {
    reverse_proxy {
      upstream {
        dial = "${docker_container.wg_easy.name}:${var.wg_internal_port}"
      }
    }
  }
}

resource "caddy_server" "wg_server" {
  depends_on = [docker_container.caddy]
  name = "wg_server"
  listen = [":80", ":443"]
  routes = [data.caddy_server_route.wg_route.id]
}
