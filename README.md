# Systemd-service-automation

This repository contains three docker based scripts. One of them creates a systemd service then enable and start it (runs a docker container), another is "uninstall" this service, stop and remove the service with the related docker container and image as well. Plus a simple running script.

### About the files

- 'application-service.sh' - Creates a systemd service on the distribution for the application.
  Its creation is tied to the running of docker service, the server machine must run it to start
  the application properly.
  (Certain distributions, such as Ubuntu, run docker.service by default on boot,
  on other distributions, the user must turn it on, such as CentOs.)

- 'application-service-uninstall.sh' - Stops and deletes the created service for the application,
  then deletes the container and the image file for the application within docker.

- 'application-run.sh' - Starts the dockerized application with the configuration
  from the mounted 'configuration' file in the folder.
