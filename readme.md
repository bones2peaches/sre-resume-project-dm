ssh scripts

# Create the temp key file with restrictive permissions

# Extract the instance IP address

# Fetch the Terraform state file and store the output

aws s3 cp s3://terragrunt-aws-sre/resume/shared/github/runner/terraform.tfstate terraform.tfstate

# Extract the private key value to check it

PRIVATE_KEY_VALUE=$(jq -r '.outputs["private_key"].value' terraform.tfstate)
echo $PRIVATE_KEY_VALUE

# If the above value is as expected and base64 encoded, decode it to a file

echo $PRIVATE_KEY_VALUE > temp_key.pem

# Fix permissions on the private key file

chmod 600 temp_key.pem

INSTANCE_IP=$(aws s3 cp s3://terragrunt-aws-sre/resume/shared/github/runner/terraform.tfstate - | jq -r '.outputs["instance_ip"].value')

# SSH into the instance

ssh -i temp_key.pem ubuntu@$INSTANCE_IP

# Remove the key file after you're done

rm -f temp_key.pem

export BUCKET_NAME=terragrunt-aws-sre
export TOKEN_PATH=resume/shared/github/repository/terraform.tfstate
export SVN_URL=https://github.com/bones2peaches/sre-resume-project-dm

terragrunt apply -all --terragrunt-ignore-external-dependencies --terragrunt-exclude-dir $(pwd)/test/\*\*

https://github.com/bones2peaches/sre-resume-project-dm

export SVN_URL=https://github.com/bones2peaches/sre-resume-project-dm

export SECRET_ID='arn:aws:secretsmanager:us-east-1:984119170260:secret:rds!db-226722cf-47b6-491f-8b08-ecc3896eeca0-CuDv8q'

SECRET=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --query SecretString --output text)

\

export DB_PASSWORD=$(aws s3 cp s3://terragrunt-aws-sre/resume/shared/github/runner/terraform.tfstate - | jq -r '.outputs["instance_ip"].value')

echo $(jq -r '.password' <<< ${SECRET} )

export DB_PASSWORD="$(jq -r '.password' <<< ${SECRET} )"

terragrunt run-all apply --terragrunt-include-dir ecs/delpoyment/svc/api --terragrunt-include-external-dependencies --terragrunt-strict-include

scp -i temp_key.pem /mnt/c/Users/Dones/fa-fork/tests/devops/postgres/test_connection.py ubuntu@${INSTANCE_IP}:/home/ubuntu/test_connection.py

terragrunt run-all apply --terragrunt-include-dir ecs/cluster --terragrunt-include-external-dependencies --terragrunt-strict-include
