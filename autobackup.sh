#!/bin/bash

# if there exist no input argument copy the output to the currecnt directory, 
# otherwise, the input argument will be used
if [ -z "$1" ]; then
    output_path=.
else
    output_path=$1
fi

# for next use to make the output file name
current_datetime=$(date +"%Y%m%d-%H%M")

container_names=$(docker ps --format "table {{.Names}}" | tail -n +2)

# if there is not exist any container, show a message and exit
if [ -z "$container_names" ]; then
   echo 'There is no running container!'
   exit 1
fi

# Delete tar files older than 1 day
find $output_path -type f -name "$hostname*.tar.xz" -mtime +1 -exec rm -rf {} \;

for container_name in $container_names; do
    
    # create a name format for the output	
    backup_image=$(hostname)""-""$container_name""-""$current_datetime

    docker commit $container_name $backup_image
    docker save $backup_image | xz -v > $output_path/$backup_image.tar.xz
    docker image rmi $backup_image
    
    echo "Backup created for container $container_name and saved to: $output_path/$backup_image.tar"
done

