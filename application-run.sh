DOCKER_IMAGE=$(DokcerImage)

# For example in dotnet application configuration file is the appsettings.json
sudo docker run -p 80:80 --mount type=bind,source="$PWD/[configuration_file]",target=/app/[configuration_file] $DOCKER_IMAGE