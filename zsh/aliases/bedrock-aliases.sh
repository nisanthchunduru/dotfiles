alias bedrock-models='aws bedrock list-foundation-models --query "modelSummaries[].modelId" --region us-east-1 --output text | tr "\t" "\n"'
