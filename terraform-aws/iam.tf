resource "aws_iam_role" "elasticsearch" {
  name               = "${var.es_cluster}-elasticsearch-discovery-role"
  assume_role_policy = "${file("${path.module}/../templates/ec2-role-trust-policy.json")}"
}

resource "aws_iam_role_policy" "elasticsearch" {
  name     = "${var.es_cluster}-elasticsearch-discovery-policy"
  policy   = "${file("${path.module}/../templates/ec2-allow-describe-instances.json")}"
  role     = "${aws_iam_role.elasticsearch.id}"
}

resource "aws_iam_instance_profile" "elasticsearch" {
  name = "${var.es_cluster}-elasticsearch-discovery-profile"
  path = "/"
  role = "${aws_iam_role.elasticsearch.name}"
}

resource "aws_iam_role_policy" "s3" {
  count  = "${var.manage_s3_iam ? 1 : 0}"
  name   = "${var.es_cluster}-elasticsearch-s3-backups"
  role   = "${aws_iam_role.elasticsearch.id}"
  policy = "${element(concat(data.aws_iam_policy_document.s3.*.json, list("")), 0)}"
}

data "aws_iam_policy_document" "s3" {
  count  = "${var.manage_s3_iam ? 1 : 0}"
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads",
      "s3:ListBucketVersions",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*",
    ]
  }

}
