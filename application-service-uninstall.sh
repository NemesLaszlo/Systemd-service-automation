# Variables
SERVICE_NAME=$(ServiceName) 
DOCKER_IMAGE=$(DokcerImage) 

# Remove systemd service
echo "Removing $SERVICE_NAME service"
sudo systemctl stop $SERVICE_NAME
sudo systemctl disable $SERVICE_NAME
sudo rm /etc/systemd/system/${SERVICE_NAME}.service
sudo systemctl daemon-reload
sudo systemctl reset-failed
echo "Remove of $SERVICE_NAME service was successful"
echo "----------------------------------------------"

# Stop and remove the dokcer container, then remove the image as well
echo "Removing $SERVICE_NAME service related docker container and image"
sudo docker rm $(sudo docker stop $(sudo docker ps -a -q --filter ancestor=$DOCKER_IMAGE --format="{{.ID}}"))
sudo docker rmi $DOCKER_IMAGE
echo "Removing $SERVICE_NAME service related docker container and image was successful"

exit 0