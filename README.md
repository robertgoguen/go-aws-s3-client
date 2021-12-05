# aws-go-s3-client

## A Simple AWS S3 Client, written in Golang

### Requires aws-cli
* sudo apt-get -y update
*
* sudo apt-get install -y python3-pip
* sudo apt-get install -y python3-venv
*
* python3 -m venv env
*
* source ./env/bin/activate
*
* pip3 install awscli
*
* pip3 install localstack
*
* SERVICES=sqs,sns,s3,lambda DEBUG=1 localstack start
*
* On another xterm do the following
*
* source ./env/bin/activate
* source ./env.sh
* ./create_s3_bucket.sh mybucket customer-1 $PWD/data
* go run main.go http://127.0.0.1:4566 s3://mybucket/customer-1/f1
* go run main.go http://127.0.0.1:4566 s3://mybucket/customer-1/f2
