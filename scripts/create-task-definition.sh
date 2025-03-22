#!/bin/bash

function create_task_definition() {
    terraform apply -refresh-only -auto-approve

    local task_name=$1
    local efs_id=$(terraform output -raw efs_id)
    local execution_role_arn=$(terraform output -raw execution_role_arn)
    local task_role_arn=$(terraform output -raw task_role_arn)
    local env_file=$5

    if [[ -z "$efs_id" || -z "$execution_role_arn" || -z "$task_role_arn" ]]; then
        echo "Error getting terraform variables."
        exit 1
    fi

    local env_vars=""
    while IFS='=' read -r key value; do
        if [[ -z "$key" || "$key" =~ ^# ]]; then
            continue
        fi
        env_vars+="{ \"name\": \"$key\", \"value\": \"$value\" },"
    done < "$env_file"

    env_vars=$(echo "$env_vars" | sed 's/,$//')

    # Define a task definition no ECS
    aws ecs register-task-definition \
        --family "$task_name" \
        --network-mode awsvpc \
        --requires-compatibilities FARGATE \
        --cpu "$2" \
        --memory "$3" \
        --execution-role-arn "$execution_role_arn" \
        --task-role-arn "$task_role_arn" \
        --container-definitions "{
            \"name\": \"$task_name\",
            \"image\": \"$4\",
            \"essential\": true,
            \"mountPoints\": [
                {
                    \"sourceVolume\": \"efs-volume\",
                    \"containerPath\": \"/mnt/data\"
                }
            ],
            \"environment\": [$env_vars]
        }" \
        --volumes "[
            {
                \"name\": \"efs-volume\",
                \"efsVolumeConfiguration\": {
                    \"fileSystemId\": \"$efs_id\",
                    \"rootDirectory\": \"/$task_name\"
                }
            }
        ]"
}
