# ContainerAutoBackup
This script automatically backs up all running containers 
How To Use:
copy autobackup.sh in a directory
cd to that directory
run chmod +x ./autobackup.sh
then run ./autobackup.sh /path/to/backup
Note: if you want to use it in cronetab delete 
echo "Backup created for container $container_name and saved to: $1/$backup_image.tar"
line 
