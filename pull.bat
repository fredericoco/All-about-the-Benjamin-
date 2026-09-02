@echo off
REM Colleague side: pulls the published image and runs it.
REM Needs VcXsrv running first (XLaunch, "Disable access control" checked).

set DOCKERHUB_USER=%1
if "%DOCKERHUB_USER%"=="" set DOCKERHUB_USER=yourdockerhubuser

docker pull %DOCKERHUB_USER%/tk-app:latest
docker run --rm -e DISPLAY=host.docker.internal:0 %DOCKERHUB_USER%/tk-app:latest
