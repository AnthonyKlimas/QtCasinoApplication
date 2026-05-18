@echo off

echo Starting Docker Desktop...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

echo Waiting for Docker to start...

:waitdocker
docker info >nul 2>&1

if errorlevel 1 (
timeout /t 5 /nobreak > nul
goto waitdocker
)

echo Docker is ready.

echo Starting MySQL container...
docker compose up -d

echo Launching QtCasino...

start /wait "" QtCasino.exe

echo QtCasino closed.
echo Stopping Docker container...

docker compose down

echo Done.
exit
