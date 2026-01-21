@echo off
REM Galatasaray Football Management System - Docker Deployment Script for Windows

echo 🔴🟡 Galatasaray Football Management System - Docker Deployment 🟡🔴
echo ==================================================================

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not installed. Please install Docker Desktop first.
    pause
    exit /b 1
)

REM Check if Docker Compose is installed
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker Compose is not installed. Please install Docker Compose first.
    pause
    exit /b 1
)

REM Check if .env file exists
if not exist .env (
    echo ⚠️  .env file not found. Creating from .env.example...
    copy .env.example .env
    echo 📝 Please edit .env file with your configuration before running again.
    pause
    exit /b 1
)

echo 🔧 Building Docker images...
docker-compose build --no-cache

echo 🚀 Starting services...
docker-compose up -d

echo ⏳ Waiting for services to be healthy...
timeout /t 10 /nobreak >nul

REM Check if the application is running
curl -f http://localhost:8080/health >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Application is running successfully!
    echo 🌐 Access the application at: http://localhost:8080
    echo 📊 API documentation at: http://localhost:8080/swagger
) else (
    echo ❌ Application failed to start. Checking logs...
    docker-compose logs galatasaray-api
    pause
    exit /b 1
)

echo.
echo 🎉 Deployment completed successfully!
echo.
echo 📋 Useful commands:
echo    View logs:     docker-compose logs -f
echo    Stop services: docker-compose down
echo    Restart:       docker-compose restart
echo    Update:        deploy.bat
echo.
echo ⚽ Galatasaray Management System is ready!
pause