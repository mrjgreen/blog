+++
title = "Building a Blog - Part 2"
date = "2016-12-23T00:02:31Z"
tags = ["Blog", "Tools", "Architecture", "Terraform", "AWS"]
series = "Building a Blog"
+++

Last time, we discussed setting up a blog using [Hugo](https://gohugo.io), a static site generator.

Today, I'm going to add to the project with some terraform configuration and a simple
build and deploy process.
<!--more-->
> TL;DR - I added terraform files in the "resources" folder to create an S3 bucket 
and a Makefile with a few canned commands for deploying.

If you don't already have them, you'll need the following tools:

* awscli (`brew install awscli` or `pip install awscli`)
* terraform (`brew install terraform` or [download for your platform](https://www.terraform.io/downloads.html))

You'll need to configure your credentials for the awscli by running:

    aws configure

## Creating the S3 Bucket

We could very quickly jump onto our AWS console and create an S3 bucket. A few clicks in the
interface and in seconds we could be up and running.

Well, that's fine for now, but what if we want to add cloudfront capabilities? Or some DNS 
records to route 53? Even with a simple static website, its easy to see how our infrastructure
could expand.

Using terraform we can store a representation of our infrastructure in code, which will be
used to drive the API commands to build your stack.

Let's start by creating a folder to hold our terraform files:

    mkdir resources/terraform

Now we can create a file `resources/terraform/s3.tf` to hold our S3 Bucket configuration:

~~~
resource "aws_s3_bucket" "blog" {
  bucket = "joeg.uk"
  acl = "public-read" # Needs to be public for a website

  versioning {
    enabled = true
  }
  
  website {
      index_document = "index.html"
      error_document = "404.html"
  }

  tags {
    Application = "Blog"
    Owner = "Joe Green"
    Provisioner = "Terraform"
    ProvisionerSrc = "github.com/mrjgreen/blog"
  }
}
~~~

> **N.B.** It's important to tag all your resources appropriately to help with identification
and cost breakdowns (E.G. see how much each "Application" is costing to run).

### Applying your Infrastructure

You should now be able to navigate to your terraform directory and run a "plan". 
A plan is a dry run, and will NOT make any changes to your infrastructure.

    cd resources/terraform
    terraform plan

Any resource created for AWS will use the terraform AWS provider, which requires a 
default region setting. By default, terraform will ask you to provide this on
the terminal whenever you run a command.

~~~
$ terraform plan
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: eu-west-1
...
~~~

In order to avoid typing this each time and to ensure all our configuration is held
in our terraform files, we can create a new file `resources/terraform/aws.tf` containing:

~~~
provider "aws" {
  region = "eu-west-1"
}
~~~

Now when we run `terraform plan` we will not be prompted for a value, and we should see
our new infrastructure component ready to create.

~~~
$ terraform plan
Refreshing Terraform state in-memory prior to plan...

// snip...

+ aws_s3_bucket.blog
    acceleration_status:      "<computed>"
    acl:                      "public-read"
    arn:                      "<computed>"
    bucket:                   "joeg.uk"
    force_destroy:            "false"
    hosted_zone_id:           "<computed>"
    region:                   "<computed>"
    request_payer:            "<computed>"
    tags.%:                   "4"
    tags.Application:         "Blog"
    tags.Owner:               "Joe Green"
    tags.Provisioner:         "Terraform"
    tags.ProvisionerSrc:      "github.com/mrjgreen/blog"
    versioning.#:             "1"
    versioning.0.enabled:     "true"
    versioning.0.mfa_delete:  "false"
    website.#:                "1"
    website.0.error_document: "404.html"
    website.0.index_document: "index.html"
    website_domain:           "<computed>"
    website_endpoint:         "<computed>"


Plan: 1 to add, 0 to change, 0 to destroy.
~~~

Lets go ahead and apply that:

    terraform apply
    
You should see pretty much the same output as before, but with the last line:
    
    Apply complete! Resources: 1 added, 0 changed, 0 destroyed.


## Deploying the Blog

Running `hugo` will generate your static site in a folder called `public`.
 
Deploying should be as easy as copying the contents of `public` up to the S3 bucket:

    aws s3 sync public s3://joeg.uk --delete --acl public-read

We can store this in a `Makefile` in the project root:

~~~
all:

build:
	rm -fr public/*
	hugo

deploy:
	aws s3 sync public s3://joeg.uk --delete --acl public-read
~~~

This will allow us to run simple commands:

    make build

and

    make deploy