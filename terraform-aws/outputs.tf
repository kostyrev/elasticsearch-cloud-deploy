output "clients_elb_dns_name" {
  value = "${aws_elb.es_client_lb.*.dns_name}"
}

output "clients_elb_zone_id" {
  value = "${aws_elb.es_client_lb.*.zone_id}"
}

output "vm_password" {
  value = "${random_string.vm-login-password.result}"
}