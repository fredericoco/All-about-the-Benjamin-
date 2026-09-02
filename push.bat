@echo off
REM Publishes the image to Docker Hub so colleagues can `docker pull` it.
REM One-time setup: docker login
REM Set your Docker Hub username below (or pass as first arg).

set DOCKERHUB_USER=%1
if "%DOCKERHUB_USER%"=="" set DOCKERHUB_USER=yourdockerhubuser

docker build -t %DOCKERHUB_USER%/tk-app:latest .
docker push %DOCKERHUB_USER%/tk-app:latest
