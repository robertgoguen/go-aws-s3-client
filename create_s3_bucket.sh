#!/bin/bash

#  create_ahc_s3_bucket_workq_item.sh
#
# $1 = bucket (string)
# $2 = customerID (string)
# $3 = directoryPath (string)
#
# Example:  ./create_s3_bucket.sh mybucket customer-1 /tmp/testfiledir
# 
# Purpose: This script is intended to be used to do *manual* end-to-end Unit Testing of aws using localstack to simulate aws services
#
# create the S3 bucket

aws --endpoint-url=http://localhost:4566 s3 mb s3://$1
aws --endpoint-url=http://localhost:4566 s3 ls 

# copy files into S3 bucket
files=$3/*
for file in ${files}; do
    printf "file: %s\n" $file
    echo "aws --endpoint-url=http://localhost:4566 s3 cp $file s3://$1/$2/"
    aws --endpoint-url=http://localhost:4566 s3 cp $file s3://$1/$2/
done
echo "aws --endpoint-url=http://localhost:4566 s3 ls s3://$1 --recursive"
aws --endpoint-url=http://localhost:4566 s3 ls s3://$1 --recursive

