resource "template_file" "deis-core" {
  filename = "${path.cwd}/conf/user-data.tpl"

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "core")}"
    units = "${file("conf/deis-core/units.yml")}"
    files = "${file("conf/deis-core/files.yml")}"
  }

}

resource "template_file" "deis_worker_units" {
  filename = "${path.cwd}/conf/deis-worker/units.tpl"
}

resource "template_file" "deis-production-worker" {
  filename = "${path.cwd}/conf/user-data.tpl"

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "production_worker")}"
    units = "${template_file.deis_worker_units.rendered}"
    files = "${file("conf/deis-worker/files.yml")}"
  }

}

resource "template_file" "deis-feature-worker" {
  filename = "${path.cwd}/conf/user-data.tpl"

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "feature_worker")}"
    units = "${template_file.deis_worker_units.rendered}"
    files = "${file("conf/deis-worker/files.yml")}"
  }

}

resource "template_file" "deis_router_units" {
  filename = "${path.cwd}/conf/deis-router/units.tpl"
}

resource "template_file" "deis-router" {
  filename = "${path.cwd}/conf/user-data.tpl"

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "router")}"
    units = "${template_file.deis_router_units.rendered}"
    files = "${file("conf/deis-router/files.yml")}"
  }

}

resource "template_file" "bastion_files" {
  filename = "${path.cwd}/conf/bastion/files.tpl"
}

resource "template_file" "bastion_units" {
  filename = "${path.cwd}/conf/bastion/units.tpl"
}

resource "template_file" "bastion" {
  filename = "${path.cwd}/conf/user-data.tpl"

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "bastion")}"
    units = "${template_file.bastion_units.rendered}"
    files = "${template_file.bastion_files.rendered}"
  }

}