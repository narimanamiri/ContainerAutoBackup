#!/bin/bash
container_names=$(docker ps --format "table {{.Names}}" | tail -n +2)
for container_name in $container_names; do
    backup_image=$container_name"backup_$(date "+%Y%m%d-%R")"
    docker commit $container_name $backup_image
    docker save -o $1/$backup_image.tar $backup_image
    docker rmi $backup_image
    echo "Backup created for container $container_name and saved to: $1/$backup_image.tar"
done
