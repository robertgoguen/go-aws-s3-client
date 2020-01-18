#!/bin/bash

#  create_ahc_s3_bucket_workq_item.sh
#
# $1 = bucket (string)
# $2 = customerID (string)
# $3 = directoryPath (string)
#
# Example:  ./create_s3_bucket.sh mybucket customer-1 /tmp/testfiledir
# 
# Purpose: This script is intended to be used to do *manual* end-to-end Unit Testing of Argos.
# It is not intended to replace end-to-end Blackbox Testing, but can be used by developers
# to test changes they are making to Argos *before* the BBT has been updated to support those
# changes.
#
# create the S3 bucket

aws --endpoint-url=http://localhost:4572 s3 mb s3://$1
aws --endpoint-url=http://localhost:4572 s3 ls 

# copy files into S3 bucket
files=$3/*
for file in ${files}; do
    printf "file: %s\n" $file
    aws --endpoint-url=http://localhost:4572 s3 cp $file s3://$1/$2/
done
aws --endpoint-url=http://localhost:4572 s3 ls s3://$1 --recursive

