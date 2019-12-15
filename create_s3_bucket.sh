#!/bin/bash

#  create_ahc_s3_bucket_workq_item.sh
#
# $1 = bucket (string)
# $2 = customerID (string)
# $3 = directoryPath (string)
#
# Example:  ./create_ahc_s3_bucket_workq_item.sh ahc-test-bucket customer-1 /tmp/testfiledir
# 
# Purpose: This script is intended to be used to do *manual* end-to-end Unit Testing of Argos.
# It is not intended to replace end-to-end Blackbox Testing, but can be used by developers
# to test changes they are making to Argos *before* the BBT has been updated to support those
# changes.
#
# The typical Manual UT steps would be:
#	1) Start up localstack with SQS and S3 services:
#		./start_localstack_sqs_s3.sh
#	2) Run this script, which will do four things:
#		a) create the SQS queue with the hardcoded name "ahc-notification-work-queue"
#		   (as currently expected by Argos)
#		b) create the S3 bucket with #1 param name
#		c) copy the files from $3 path param (local directory path) to the S3 bucket
#		   specified as "s3://#1/#2/" -> "s3://bucket/customer/"
#		d) Inject a message into the SQS queue specifying the customer and bucket/path,
#		   which should cause Argos to be excercised from the Results Listener and through
#		   the Business Logic and to the Data Base.
#	3) The user can then manually use curl commands to verify the entries were
#	   correctly added/updated in the database, and that the Argos REST api
#	   correctly processes the queries.  Example:
#		curl -X GET "http://127.0.0.1:8181/matches/pending?customer-id=customer-1" | jq
#
#
# The user can execute this scrip multiple times, specifying different directoryPaths, and/or
# different customerIDs.  Re-executing with all the same params is also acceptable, and should
# results in DB updates (as opposed to adds).  The bucket could also be varied, and should be
# processed with no issues (though this would not be the normal production experience, where a
# single bucket is planned).

# create the SQS queue
/usr/bin/aws --endpoint-url=http://localhost:4576 sqs create-queue --queue-name ahc-notification-work-queue 

# create the S3 bucket
/usr/bin/aws --endpoint-url=http://localhost:4572 s3 mb s3://$1
/usr/bin/aws --endpoint-url=http://localhost:4572 s3 ls 

# copy files into S3 bucket
files=$3/*
for file in ${files}; do
    printf "file: %s\n" $file
    /usr/bin/aws --endpoint-url=http://localhost:4572 s3 cp $file s3://$1/$2/
done
/usr/bin/aws --endpoint-url=http://localhost:4572 s3 ls s3://$1 --recursive

# add work item to customer work queue
aws --endpoint-url http://localhost:4576 sqs send-message --queue-url http://localhost:4576/queue/ahc-notification-work-queue  --message-body '{"Message" : "{\"version\":\"1\",\"customer_id\":\"'$2'\",\"location\":\"s3://'$1'/'$2'\",\"timestamp\":\"2017-12-18T17:14:35Z\"}"}'

