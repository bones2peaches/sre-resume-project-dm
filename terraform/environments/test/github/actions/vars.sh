#!/bin/bash

export TF_VAR_environment_variables="{\"FRONTEND_HOST_NAME\": \"test.bones2peaches.com\", \"API_HOST_NAME\": \"test-api.bones2peaches.com\"}"
export TF_VAR_environment_secrets="{\"VERCEL_API_TOKEN\": \"$VERCEL_API_TOKEN\",
 \"AWS_ACCESS_KEY_ID\": \"$AWS_ACCESS_KEY_ID\",
  \"AWS_SECRET_ACCESS_KEY\": \"$AWS_SECRET_ACCESS_KEY\",
     \"BUCKET_NAME\" : \"$BUCKET_NAME\",
     \"AWS_ACCOUNT_ID\" : \"$AWS_ACCOUNT_ID\",
}"
