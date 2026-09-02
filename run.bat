@echo off
REM Needs VcXsrv running first (XLaunch, "Disable access control" checked).
REM Download: https://sourceforge.net/projects/vcxsrv/

docker build -t tk-app .
docker run --rm -e DISPLAY=host.docker.internal:0 tk-app
