# CoffeeMonkey.net

This is the terraform configuration to setup my AWS for my [CoffeeMonkey site](https://coffeemonkey.net).

## Prerequisites

### Terraform:

* Go download the binary from the website and put it on your path

### AWS CLI

    $ pip install awscli


## To run

### Setup infrastructure:

    $ terraform init
    $ terraform plan
    $ terraform apply

### Deploy site

This needs to be done from the coffeemonkey.net git repo.

    $ aws s3 sync . s3://www.coffeemonkey.net

    $ npm deploy
