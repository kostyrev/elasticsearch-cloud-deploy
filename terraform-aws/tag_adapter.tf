locals {
  tags = "${null_resource.tag_adapter.*.triggers}"
}

resource "null_resource" "tag_adapter" {
  triggers {
    key                 = "${element(keys(var.tags), count.index)}"
    value               = "${element(values(var.tags), count.index)}"
    propagate_at_launch = true
  }

  count = "${length(var.tags)}"
}
