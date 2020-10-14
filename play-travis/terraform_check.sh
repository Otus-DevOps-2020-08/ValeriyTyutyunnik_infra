#!/bin/bash
set -v

echo " === Begin stage validate: =="
cd terraform/stage
terraform init -backend=false
terraform validate
tflint

echo " === Begin prod validate: =="
cd ../prod
terraform init -backend=false
terraform validate
tflint
