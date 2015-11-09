# Core Templates
resource "template_file" "deis-core" {
  filename = "${path.cwd}/conf/user-data.tpl"

  provisioner "local-exec" {
    command = "mkdir -p ./tmp/deis-core && cat <<'__USERDATA__' > ./tmp/deis-core/user_data.yml\n${template_file.deis-core.rendered}\n__USERDATA__"
  }

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "core")}"
    units = "${file("conf/deis-core/units.yml")}"
    files = "${file("conf/deis-core/files.yml")}"
  }

}

# Production Worker Templates
resource "template_file" "deis-production-worker" {
  filename = "${path.cwd}/conf/user-data.tpl"

  provisioner "local-exec" {
    command = "mkdir -p ./tmp/deis-production-worker && cat <<'__USERDATA__' > ./tmp/deis-production-worker/user_data.yml\n${template_file.deis-production-worker.rendered}\n__USERDATA__"
  }

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "production_worker")}"
    units = "${file("conf/deis-worker/units.yml")}"
    files = "${file("conf/deis-worker/files.yml")}"
  }

}

# Feature Worker Templates
resource "template_file" "deis-feature-worker" {
  filename = "${path.cwd}/conf/user-data.tpl"

  provisioner "local-exec" {
    command = "mkdir -p ./tmp/deis-feature-worker && cat <<'__USERDATA__' > ./tmp/deis-feature-worker/user_data.yml\n${template_file.deis-feature-worker.rendered}\n__USERDATA__"
  }

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "feature_worker")}"
    units = "${file("conf/deis-worker/units.yml")}"
    files = "${file("conf/deis-worker/files.yml")}"
  }

}

# Router Templates
resource "template_file" "deis-router" {
  filename = "${path.cwd}/conf/user-data.tpl"

  provisioner "local-exec" {
    command = "mkdir -p ./tmp/deis-router && cat <<'__USERDATA__' > ./tmp/deis-router/user_data.yml\n${template_file.deis-router.rendered}\n__USERDATA__"
  }

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "router")}"
    units = "${file("conf/deis-router/units.yml")}"
    files = "${file("conf/deis-router/files.yml")}"
  }

}

# Bastion Templates
resource "template_file" "bastion_files" {
  filename = "${path.cwd}/conf/bastion/files.tpl"
}

resource "template_file" "bastion_units" {
  filename = "${path.cwd}/conf/bastion/units.tpl"
}

resource "template_file" "bastion" {
  filename = "${path.cwd}/conf/user-data.tpl"

  provisioner "local-exec" {
    command = "mkdir -p ./tmp/bastion && cat <<'__USERDATA__' > ./tmp/bastion/user_data.yml\n${template_file.bastion.rendered}\n__USERDATA__"
  }

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "bastion")}"
    units = "${template_file.bastion_units.rendered}"
    files = "${template_file.bastion_files.rendered}"
  }

}

# Proxy Gateway Templates
resource "template_file" "proxy-gateway" {
  filename = "${path.cwd}/conf/user-data.tpl"

  provisioner "local-exec" {
    command = "mkdir -p ./tmp/proxy-gateway && cat <<'__USERDATA__' > ./tmp/proxy-gateway/user_data.yml\n${template_file.proxy-gateway.rendered}\n__USERDATA__"
  }

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "proxy-gateway")}"
    units = "${file("conf/proxy-gateway/units.yml")}"
    files = "${file("conf/proxy-gateway/files.yml")}"
  }

}