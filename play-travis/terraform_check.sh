#!/bin/bash

echo " -= terraform stage validate begin =-"
cd terraform/stage
terraform init -backend=false
terraform validate
tflint

echo " -= terraform prod validate begin =-"
cd ../prod
terraform init -backend=false
terraform validate
tflint
