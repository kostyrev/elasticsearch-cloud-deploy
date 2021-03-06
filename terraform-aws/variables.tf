### MANDATORY ###
variable "es_cluster" {
  description = "Name of the elasticsearch cluster, used in node discovery"
}

variable "aws_region" {
  type = "string"
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = "string"
  default = "10.0.0.0/16"
}

variable "vpc_id" {
  description = "VPC ID to create the Elasticsearch cluster in"
  type = "string"
  default = ""
}


variable "vpc_subnets" {
  description = "VPC subnet IDs to create the Elasticsearch cluster in"
  type = "list"
  default = [""]
}

variable "availability_zones" {
  type = "list"
  description = "AWS region to launch servers; if not set the available zones will be detected automatically"
  default = []
}

variable "key_name" {
  description = "Key name to be used with the launched EC2 instances."
  default = "elasticsearch"
}

variable "environment" {
  default = "default"
}

variable "data_instance_type" {
  type = "string"
  default = "c4.2xlarge"
}

variable "master_instance_type" {
  type = "string"
  default = "m4.large"
}

variable "client_instance_type" {
  type = "string"
  default = "m4.large"
}

variable "elasticsearch_volume_size" {
  type = "string"
  default = "100" # gb
}

variable "volume_name" {
  default = "/dev/xvdh"
}

variable "volume_encryption" {
  default = true
}

variable "elasticsearch_data_dir" {
  default = "/opt/elasticsearch/data"
}

variable "elasticsearch_logs_dir" {
  default = "/var/log/elasticsearch"
}

# default elasticsearch heap size
variable "data_heap_size" {
  type = "string"
  default = "7g"
}

variable "master_heap_size" {
  type = "string"
  default = "2g"
}

variable "client_heap_size" {
  type = "string"
  default = "1g"
}

variable "masters_count" {
  default = "0"
}

variable "datas_count" {
  default = "0"
}

variable "clients_count" {
  default = "0"
}

variable "security_enabled" {
  description = "Whether or not to enable x-pack security on the cluster"
  default = "false"
}

variable "monitoring_enabled" {
  description = "Whether or not to enable x-pack monitoring on the cluster"
  default = "true"
}

# client nodes have nginx installed on them, these credentials are used for basic auth
variable "client_user" {
  default = "exampleuser"
}

variable "public_facing" {
  description = "Whether or not the created cluster should be accessible from the public internet"
  type = "string"
  default = "true"
}

# the ability to add additional existing security groups. In our case
# we have consul running as agents on the box
variable "additional_security_groups" {
  type = "list"
  default = []
}

variable "health_check_type" {
  description = "Controls how health checking is done. Must be one of EC2 or ELB."
  default     = "EC2"
}

variable "ebs_optimized" {
  description = "Whether data instances are EBS optimized or not"
  default = "true"
}

variable "tags" {
  description = "Additional instance tags"
  default     = {}
}

variable "lb_port" {
  description = "The port the load balancer should listen on for API requests."
  default     = 80
}

variable "client_pwd" {
  description = "Set admin password for kibana, generated if not provided"
  default = "GENERATE"
}

variable "manage_s3_iam" {
  description = "Whether to configure IAM policy for S3 backups"
  default     = false
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to use for backups. Only used if 'manage_s3_iam' is set to true."
  default     = ""
}
