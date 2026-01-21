# Galatasaray-Management-System

Galatasaray Management System
A comprehensive web-based management system built with ASP.NET Core 8.0, featuring Docker support, RESTful API, and a modern SPA frontend.
Overview
This project is a full-stack management system designed for Galatasaray organization. It includes a backend API built with ASP.NET Core, Entity Framework Core for data access, and a modern frontend Single Page Application (SPA). The system is fully containerized using Docker for easy deployment and scalability.
Features

RESTful API: Clean architecture with ASP.NET Core 8.0
Database Integration: Entity Framework Core with SQL Server support
Docker Support: Fully containerized application with Docker Compose
Health Monitoring: Built-in health check endpoint with database connectivity testing
Swagger Documentation: Interactive API documentation at /swagger
SPA Frontend: Modern single-page application served through static files
Logging: Comprehensive logging with console and debug providers
Clean Architecture: Separation of concerns with Application and Infrastructure layers

Technology Stack
Backend

Framework: ASP.NET Core 8.0
ORM: Entity Framework Core
Database: SQL Server (configurable)
API Documentation: Swagger/OpenAPI
Containerization: Docker & Docker Compose
Port: 8080

Architecture

Pattern: Clean Architecture
Layers:

API Layer (Presentation)
Application Layer (Business Logic)
Infrastructure Layer (Data Access, External Services)



Prerequisites
Before running this application, you need to install the following software:
Required Software
1. Docker Desktop (REQUIRED)
Docker Desktop includes both Docker Engine and Docker Compose.
Windows:

Download from Docker Desktop for Windows
System Requirements: Windows 10/11 (64-bit), WSL 2 enabled
Installation Steps:

Download the installer
Run Docker Desktop Installer.exe
Follow the installation wizard
Restart your computer
Launch Docker Desktop and wait for it to start



macOS:

Download from Docker Desktop for Mac
System Requirements: macOS 11 or newer
Installation Steps:

Download Docker.dmg
Drag Docker to Applications folder
Launch Docker from Applications
Grant necessary permissions



Linux:

Follow instructions at Docker Engine for Linux
Install Docker Compose separately: Docker Compose Installation

Verify Installation:
bashdocker --version
docker-compose --version
2. .NET 8.0 SDK (Optional - only if running without Docker)

Download from .NET 8.0 Download
Choose SDK (not Runtime)
Verify installation:

bashdotnet --version
3. Git (Recommended)

Download from Git Official Site
Verify installation:

bashgit --version
Project Structure
GalatasaraySystem/
├── GalatasaraySystem.API/          # API Layer
│   ├── Controllers/                # API Controllers
│   ├── Program.cs                  # Application entry point
│   └── wwwroot/                    # Static files for SPA
├── GalatasaraySystem.Application/  # Business Logic Layer
├── GalatasaraySystem.Infrastructure/ # Data Access Layer
│   ├── Data/                       # DbContext
│   └── Services/                   # Infrastructure services
├── docker-compose.yml              # Docker composition file
├── Dockerfile                      # Docker image definition
└── README.md                       # This file
Installation & Setup
Step 1: Clone or Download the Project
bash# If using Git
git clone <repository-url>
cd GalatasaraySystem

# Or download ZIP and extract
Step 2: Configure Application Settings
Edit appsettings.json or appsettings.Development.json:
json{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=GalatasarayDB;User Id=sa;Password=YourPassword123!;TrustServerCertificate=True"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  }
}
Step 3: Start Docker Desktop

Open Docker Desktop application
Wait until Docker is running (whale icon in system tray should be steady)
Ensure Docker is set to Linux containers mode

Running the Application
Method 1: Using Docker Compose (Recommended)
Start the Application
Open terminal/command prompt in project directory and run:
bash# Start all services (API + Database)
docker-compose up -d
The -d flag runs containers in detached mode (background).
Check Running Containers
bash# List all running containers
docker ps
You should see containers for the API and database.
View Application Logs
bash# View logs for the API service
docker-compose logs -f galatasaray-management-api
Press Ctrl+C to stop viewing logs (containers continue running).
Access the Application
Open your browser and navigate to:

Application: http://localhost:8080
Swagger API Documentation: http://localhost:8080/swagger
Health Check: http://localhost:8080/health

Using PowerShell (Windows):
powershell# Open main application
Start-Process "http://localhost:8080"

# Open Swagger documentation
Start-Process "http://localhost:8080/swagger"
Stop the Application
bash# Stop all services
docker-compose down
This stops and removes all containers.
Rebuild and Restart
If you make code changes:
bash# Rebuild images and restart containers
docker-compose up --build -d
Method 2: Running Without Docker
If you have .NET 8.0 SDK installed:
bash# Navigate to API project
cd GalatasaraySystem.API

# Restore dependencies
dotnet restore

# Run the application
dotnet run
The application will start on the configured port (usually http://localhost:5000).
Common Commands Reference
Docker Commands
bash# Check Docker installation
docker --version
docker-compose --version

# View running containers
docker ps

# View all containers (including stopped)
docker ps -a

# Start services
docker-compose up -d

# Stop services
docker-compose down

# Rebuild and start
docker-compose up --build -d

# View logs (follow mode)
docker-compose logs -f galatasaray-management-api

# View logs for all services
docker-compose logs -f

# Restart a specific service
docker-compose restart galatasaray-management-api

# Remove all containers and volumes
docker-compose down -v

# Execute command in running container
docker exec -it <container-id> /bin/bash
Network Troubleshooting
Check if port 8080 is in use (Windows):
cmdnetstat -ano | findstr :8080
Check if port 8080 is in use (Linux/Mac):
bashlsof -i :8080
# or
netstat -tuln | grep 8080
Kill process using port 8080 (Windows):
cmd# Find PID from netstat output, then:
taskkill /PID <process-id> /F
Kill process using port 8080 (Linux/Mac):
bash# Find PID, then:
kill -9 <process-id>
.NET Commands
bash# Restore packages
dotnet restore

# Build project
dotnet build

# Run application
dotnet run

# Run with specific environment
dotnet run --environment Development

# Apply database migrations
dotnet ef database update

# Create new migration
dotnet ef migrations add MigrationName
API Endpoints
Health Check

GET /health - Returns system health status and database connectivity

Swagger Documentation

GET /swagger - Interactive API documentation
GET /swagger/v1/swagger.json - OpenAPI specification

Additional Endpoints
All API endpoints are documented in Swagger. Access Swagger UI for complete documentation.
Configuration
Application Settings
The application uses appsettings.json for configuration:
json{
  "ConnectionStrings": {
    "DefaultConnection": "Server=db;Database=GalatasarayDB;User Id=sa;Password=YourPassword123!;TrustServerCertificate=True"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning",
      "Microsoft.EntityFrameworkCore": "Information"
    }
  },
  "AllowedHosts": "*"
}
Docker Configuration
Dockerfile - Defines the container image:

Multi-stage build for optimized image size
Based on official ASP.NET Core runtime
Exposes port 8080

docker-compose.yml - Orchestrates multiple containers:

API service
SQL Server database (if configured)
Network configuration
Volume mappings

Environment Variables
You can override settings using environment variables:
bash# In docker-compose.yml
environment:
  - ASPNETCORE_ENVIRONMENT=Development
  - ConnectionStrings__DefaultConnection=Server=db;Database=...
Database Management
Migrations
If Entity Framework migrations are enabled:
bash# Add new migration
dotnet ef migrations add InitialCreate

# Update database
dotnet ef database update

# Rollback migration
dotnet ef database update PreviousMigrationName

# Remove last migration
dotnet ef migrations remove
Seed Data
The application includes a seed data service (currently disabled in Program.cs). To enable:

Uncomment the seed data section in Program.cs
Restart the application
Initial data will be populated on startup

Troubleshooting
Common Issues
1. Docker Desktop Not Running
Error: "Cannot connect to Docker daemon"
Solution:

Start Docker Desktop
Wait for it to fully start (whale icon steady)
Try command again

2. Port 8080 Already in Use
Error: "Address already in use"
Solution:
bash# Find and kill the process using port 8080
# Windows:
netstat -ano | findstr :8080
taskkill /PID <process-id> /F

# Linux/Mac:
lsof -i :8080
kill -9 <process-id>
3. Database Connection Failed
Error: "Cannot connect to database"
Solution:

Check if database container is running: docker ps
Verify connection string in appsettings.json
Check database logs: docker-compose logs -f db
Restart services: docker-compose restart

4. Container Build Failed
Error: Build errors during docker-compose up
Solution:
bash# Clean everything and rebuild
docker-compose down -v
docker system prune -a
docker-compose up --build -d
5. Cannot Access Application
Error: "This site can't be reached"
Solution:

Verify container is running: docker ps
Check container logs: docker-compose logs -f
Verify port mapping in docker-compose.yml
Try: http://localhost:8080 (not https)
Clear browser cache or try incognito mode

Logging
View detailed logs:
bash# All services
docker-compose logs -f

# Specific service
docker-compose logs -f galatasaray-management-api

# Last 100 lines
docker-compose logs --tail=100 galatasaray-management-api

# Since specific time
docker-compose logs --since 2024-01-01T00:00:00
Development Workflow
Making Changes

Make code changes in your IDE
Rebuild and restart:

bashdocker-compose up --build -d

View logs to verify changes:

bashdocker-compose logs -f galatasaray-management-api
Debugging
Using Visual Studio

Set Docker Compose as startup project
Press F5 to debug
Breakpoints will work normally

Using VS Code

Install Docker extension
Use "Docker: Attach to .NET Core" configuration
Set breakpoints and debug

Manual Debugging
bash# Run with debug logging
docker-compose up

# Watch logs in real-time
docker-compose logs -f
Production Deployment
Best Practices

Use Production Configuration

bashASPNETCORE_ENVIRONMENT=Production

Enable HTTPS


Uncomment app.UseHttpsRedirection() in Program.cs
Configure SSL certificates


Secure Secrets


Use environment variables or Azure Key Vault
Never commit secrets to source control


Optimize Docker Images


Multi-stage builds (already implemented)
Minimize layer count
Use specific version tags


Database Backups


Regular automated backups
Test restore procedures

Performance Optimization

Enable Response Compression
Use Response Caching
Implement API Rate Limiting
Database Indexing
Connection Pooling (already configured in EF Core)
CDN for Static Files

Security Considerations

Authentication & Authorization: Implement JWT or OAuth2
CORS Configuration: Configure allowed origins
API Rate Limiting: Prevent abuse
Input Validation: Validate all user inputs
SQL Injection Protection: Use parameterized queries (EF Core handles this)
HTTPS: Enable in production
Secrets Management: Use secure secret storage

Testing
Unit Tests
bashdotnet test
Integration Tests

Use TestContainers for database testing
Mock external services

API Testing

Use Swagger UI for manual testing
Postman collection (if provided)
Automated API tests

Quick Start Checklist

 Install Docker Desktop
 Start Docker Desktop
 Clone/download project
 Open terminal in project directory
 Run docker-compose up -d
 Wait for containers to start
 Run docker ps to verify containers are running
 Open http://localhost:8080 in browser
 Test API at http://localhost:8080/swagger
 Check health at http://localhost:8080/health

Support
Documentation

ASP.NET Core: https://docs.microsoft.com/aspnet/core
Entity Framework Core: https://docs.microsoft.com/ef/core
Docker: https://docs.docker.com

Getting Help

Check logs: docker-compose logs -f
Review health endpoint: http://localhost:8080/health
Consult troubleshooting section above

License
This project is provided as-is for educational and internal use.
Contributors
Developed for Galatasaray organization management system.

Version: 1.0.0
Last Updated: January 2026
Framework: ASP.NET Core 8.0
Database: SQL Server
Container Platform: Docker
