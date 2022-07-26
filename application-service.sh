# Variables
SERVICE_NAME=$(ServiceName)
DOCKER_IMAGE=$(DokcerImage)

# For example in dotnet application configuration file is the appsettings.json
# docker run -p 80:80 --mount type=bind,source=$PWD/[configuration_file],target=/app/[configuration_file] $DOCKER_IMAGE

# Check if service is active
IS_ACTIVE=$(sudo systemctl is-active $SERVICE_NAME)
if [ "$IS_ACTIVE" == "active" ]; then
    # Restart the service
    echo "Service is running"
    echo "Restarting service"
    sudo systemctl restart $SERVICE_NAME
    echo "Service restarted"
else
    # Create service file
    echo "Creating service file"
    sudo cat > /etc/systemd/system/${SERVICE_NAME}.service << EOF
[Unit]
Description=$SERVICE_NAME Container
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStart=/usr/bin/docker run -p 80:80 --mount type=bind,source=$PWD/[configuration_file],target=/app/[configuration_file] $DOCKER_IMAGE

[Install]
WantedBy=multi-user.target
EOF
    # Restart daemon, enable and start service
    echo "Reloading daemon and enabling service"
    sudo systemctl daemon-reload 
    sudo systemctl enable ${SERVICE_NAME//'.service'/} # remove the extension
    sudo systemctl start ${SERVICE_NAME//'.service'/}  # remove the extension
    echo "Service Started"
fi

exit 0