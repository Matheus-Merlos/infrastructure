#!/bin/bash

function create_task_definition() {

    local task_name=$1
    local efs_id=$6
    local execution_role_arn=$7
    local task_role_arn=$8
    local env_file=$5

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
