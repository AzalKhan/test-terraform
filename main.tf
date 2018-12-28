
provider "aws" {
  region     = "${var.AWS_REGION_NAME}"
}

#=====================================================

resource "aws_security_group" "test-sg-allow_all" {
name        = "allow_all"
#vpc_id = "${aws_vpc.testVPC.id}"
tags {
       Name = "allow_all"
    }
    
ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#=====================================================
resource "aws_vpc" "testVPC" {
    cidr_block       = "${var.VPC_CIDR}"
    instance_tenancy = "${var.INSTANCE_TENANCY}"

    tags {
      Name = "Test-VPC"
    }
  } 

#=====================================================

resource "aws_subnet" "testVPC-public-subnet" {
  vpc_id              = "${aws_vpc.testVPC.id}"
  cidr_block          = "${var.PUBLIC_SUBNET_CIDR}"
  availability_zone   = "${var.AVAILABILITY_ZONE}"
  

  tags {
    Name = "T Public Subnet"
  }
}
#=======================================================

resource "aws_instance" "testEC2" {
#vpc_id        = "${aws_vpc.testVPC.id}"
ami                     = "${var.AMI_IMAGE}" 
instance_type           = "${var.INSTANCE_TYPE}"
key_name                = "${var.KEYPAIR}"
vpc_security_group_ids  = "${var.VPC_SECURITY_GROUP_IDS}"
subnet_id               = "${aws_subnet.testVPC-public-subnet.id}"
tags {
    Name = "Test-EC2"
  } 

}

#------------------------------------------------------------

resource "aws_instance" "exmapleEC2" {
#vpc_id       = "${aws_vpc.testVPC.id}"
ami           = "${var.AMI_IMAGE}"         # Ubuntu Server 18.04 LTS 
instance_type = "${var.INSTANCE_TYPE}"
key_name      = "${var.KEYPAIR}"
tags {
    Name      = "Test-EC2"
  } 

}

#===========================================================

#2.1 create s3 in AWS
resource "aws_s3_bucket" "bucket" {
    bucket            = "${var.BUCKET_NAME}"
    acl               = "${var.NETWORK_ACL}"
    region            = "${var.AWS_REGION_NAME}"
    versioning {
            enabled   = true
    }
    tags {
        Name          = "Prac-S3-Bucket"
    }
}
/*
#2.2 Moving object to S3 bucket
resource "aws_s3_bucket_object" "object" {
  bucket = "${var.BUCKET_NAME}-tfstate"
  key    = "${var.KEYPAIR}"
  source = "${var.ENV_PATH}"
}


#2.2 Moving state file to S3 bucket


terraform {
  backend "s3" {
    bucket = "prac-s3-bucket-tfstate"
    encrypt = true
    key    = "~/Documents/test/terrafrom.tfstate"
    region = "ap-south-1"
  # source = "~/Documents/test/terrafrom.tfstate"
  }
}
*/

#================================================================================
/*
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "1.12.0"

  name                   = "my-cluster"
  instance_count         = 1

  ami                    = "${var.AMI_IMAGE}"
  instance_type          = "${var.INSTANCE_TYPE}"
  key_name               = "${var.KEYPAIR}"
  monitoring             = true
  vpc_security_group_ids = "${var.VPC_SECURITY_GROUP_IDS}"
  subnet_id              = "${aws_subnet.testVPC-public-subnet.id}"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
*/