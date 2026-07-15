alias bedrock-models-ids='aws bedrock list-foundation-models --query "modelSummaries[].modelId" --output text | tr "\t" "\n"'
alias us-east-1-bedrock-models-ids='aws bedrock list-foundation-models --query "modelSummaries[].modelId" --region us-east-1 --output text | tr "\t" "\n"'

us-east-1-bedrock-model-inference-profile-arn() {
  local MODEL_ID="$1"

  if [[ -z "$MODEL_ID" ]]; then
    echo "usage: inference-profile <model-id>" >&2
    return 1
  fi

  local TYPES
  TYPES=$(
    aws bedrock get-foundation-model \
        --model-identifier "$MODEL_ID" \
        --query 'modelDetails.inferenceTypesSupported' \
        --output json \
        --region us-east-1 \
        2>/dev/null
    )

  if [[ $? -ne 0 ]]; then
    echo "Failed to fetch model $MODEL_ID details" >&2
    return 1
  fi

  if echo "$TYPES" | grep -q 'ON_DEMAND'; then
    echo "$MODEL_ID"
    return 0
  fi

  local PROFILE_ARN
  PROFILE_ARN=$(
    aws bedrock list-inference-profiles \
        --query "inferenceProfileSummaries[?contains(models[0].modelArn, '$MODEL_ID')].inferenceProfileArn | [0]" \
        --region us-east-1 \
        --output text \
        2>/dev/null
    )

  if [[ -z "$PROFILE_ARN" || "$PROFILE_ARN" == "None" ]]; then
    echo "Model $MODEL_ID requires an inference profile but none found" >&2
    return 2
  fi

  echo "$PROFILE_ARN"
}

alias bedrock-mantle-models-ids='awscurl --service bedrock-mantle https://bedrock-mantle.us-east-1.api.aws/v1/models | jq -r ".data[].id"'
alias us-east-1-bedrock-mantle-models-ids='awscurl --service bedrock-mantle --region us-east-1 https://bedrock-mantle.us-east-1.api.aws/v1/models | jq -r ".data[].id"'
