resource "template_file" "deis-core" {
  filename = "${path.cwd}/conf/user-data.tpl"

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "core")}"
    units = "${file("conf/deis-core/units.yml")}"
    files = "${file("conf/deis-core/files.yml")}"
  }

}

resource "template_file" "deis-production-worker" {
  filename = "${path.cwd}/conf/user-data.tpl"

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "production_worker")}"
    units = "${file("conf/deis-worker/units.yml")}"
    files = "${file("conf/deis-worker/files.yml")}"
  }

}

resource "template_file" "deis-feature-worker" {
  filename = "${path.cwd}/conf/user-data.tpl"

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "feature_worker")}"
    units = "${file("conf/deis-worker/units.yml")}"
    files = "${file("conf/deis-worker/files.yml")}"
  }

}

resource "template_file" "bastion_files" {
  filename = "${path.cwd}/conf/bastion/files.tpl"
}

resource "template_file" "bastion" {
  filename = "${path.cwd}/conf/user-data.tpl"

  vars {
    fleet_tags = "${lookup(var.fleet_tags, "bastion")}"
    units = "${file("conf/bastion/units.yml")}"
    files = "${template_file.bastion_files.rendered}"
  }

}