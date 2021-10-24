# !/usr/bin/env bash

# manually set from serverless.yml
SERVICE="jwt-auth"
STAGE="dev"
REGION="eu-west-1"

SSM_CMD="aws ssm get-parameter --query Parameter.Value --output text --region $REGION"

CLIENT_ID_SSM_PATH="/$SERVICE/$STAGE/cognitoUserPoolClientId"
USER_POOL_ID_SSM_PATH="/$SERVICE/$STAGE/cognitoUserPoolId"
USER_POOL_DOMAIN_ENDPOINT_SSM_PATH="/$SERVICE/$STAGE/cognitoUserPoolDomainEndpoint"
API_ENDPOINT_SSM_PATH="/$SERVICE/$STAGE/apiEndpoint"

echo "Getting SSM Parameters Values..."
CLIENT_ID=$($SSM_CMD --name "$CLIENT_ID_SSM_PATH")
USER_POOL_ID=$($SSM_CMD --name "$USER_POOL_ID_SSM_PATH")
USER_POOL_DOMAIN_ENDPOINT=$($SSM_CMD --name "$USER_POOL_DOMAIN_ENDPOINT_SSM_PATH")
API_ENDPOINT=$($SSM_CMD --name "$API_ENDPOINT_SSM_PATH")

echo "Getting Cognito User Pool Client Secret..."
CLIENT_SECRET=$(aws cognito-idp describe-user-pool-client --user-pool-id "$USER_POOL_ID"  --region $REGION --client-id "$CLIENT_ID" --query 'UserPoolClient.ClientSecret' --output text)

echo "Retrieving Access Token from User Pool Client..."
ACCESS_TOKEN=$(curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET" \
  "$USER_POOL_DOMAIN_ENDPOINT/oauth2/token" | jq -r '.access_token')

echo "Making request to API Gateway..."
curl -X GET -H "Authorization: $ACCESS_TOKEN" -H "Content-Type: application/json" "$API_ENDPOINT/query/exampleId"
