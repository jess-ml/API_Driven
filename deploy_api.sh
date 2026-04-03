#!/bin/bash
ENDPOINT="http://localhost:4566"
REGION="us-east-1"
LAMBDA_ARN="arn:aws:lambda:us-east-1:000000000000:function:EC2Controller"

echo "1. Création de l'API Gateway..."
API_ID=$(aws --endpoint-url=$ENDPOINT apigateway create-rest-api --name EC2ControlAPI --region $REGION --query 'id' --output text)
echo "   -> API_ID généré : $API_ID"

echo "2. Récupération de la racine de l'API..."
PARENT_ID=$(aws --endpoint-url=$ENDPOINT apigateway get-resources --rest-api-id $API_ID --region $REGION --query 'items[0].id' --output text)

echo "3. Création de la route /ec2..."
RESOURCE_ID=$(aws --endpoint-url=$ENDPOINT apigateway create-resource --rest-api-id $API_ID --parent-id $PARENT_ID --path-part ec2 --region $REGION --query 'id' --output text)

echo "4. Création de la méthode GET..."
aws --endpoint-url=$ENDPOINT apigateway put-method --rest-api-id $API_ID --resource-id $RESOURCE_ID --http-method GET --authorization-type "NONE" --region $REGION > /dev/null

echo "5. Liaison de l'API avec la fonction Lambda (Intégration)..."
aws --endpoint-url=$ENDPOINT apigateway put-integration \
    --rest-api-id $API_ID \
    --resource-id $RESOURCE_ID \
    --http-method GET \
    --type AWS_PROXY \
    --integration-http-method POST \
    --uri arn:aws:apigateway:$REGION:lambda:path/2015-03-31/functions/$LAMBDA_ARN/invocations \
    --region $REGION > /dev/null

echo "6. Déploiement de l'API en production..."
aws --endpoint-url=$ENDPOINT apigateway create-deployment --rest-api-id $API_ID --stage-name prod --region $REGION > /dev/null

echo "=================================================="
echo "SUCCES ! Le chemin de ton API est :"
echo "/restapis/$API_ID/prod/_user_request_/ec2"
echo "=================================================="
