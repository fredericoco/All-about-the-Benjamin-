# Dockerizing a tkinter + batch-file app

## Layout
```
app/main.py          tkinter GUI, orchestrates processing via subprocess
app/process.sh        stand-in for your data-processing logic
app/requirements.txt  add real pip deps here
Dockerfile
run.bat               build + run on Windows
```

## The catch: .bat won't run in the container
Docker containers here are Linux. `cmd.exe` and `.bat` scripts don't exist there.
Port each `.bat`'s logic to a `.sh` script (or straight Python) — same steps,
different shell. The GUI still calls it the same way, just via `sh` instead
of `cmd`:
```python
subprocess.run(["sh", "process.sh"])
```
If a `.bat` shells out to a Windows-only exe (e.g. some proprietary tool),
that exe needs a Linux build/equivalent too, or you're stuck on Windows
containers.

## GUI in a container = no display
The container has no screen. tkinter needs an X server to draw to, so on
Windows:
1. Install [VcXsrv](https://sourceforge.net/projects/vcxsrv/), run XLaunch,
   check "Disable access control".
2. `run.bat` builds the image and runs it with `DISPLAY` pointed at your
   host, so the GUI window pops up on your desktop as if it were local.

## Sharing with colleagues via Docker Hub
One-time: create a [Docker Hub](https://hub.docker.com) account, then locally:
```
docker login
```
Publish:
```
push.bat <your-dockerhub-username>
```
Colleague side (no build, no repo clone needed — just Docker + VcXsrv):
```
pull.bat <your-dockerhub-username>
```
Image is public by default on Docker Hub's free tier — make it private in
the Docker Hub UI if the code/data shouldn't be public, and have colleagues
`docker login` first in that case.
