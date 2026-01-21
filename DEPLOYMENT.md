# 🔴🟡 Galatasaray Football Management System - Deployment Guide 🟡🔴

## Overview

This guide provides complete instructions for deploying the Galatasaray Football Management System in production environments.

## System Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Frontend      │    │   .NET 8 API     │    │   PostgreSQL    │
│   (Tailwind)    │◄──►│   (Clean Arch)   │◄──►│   (Supabase)    │
│   Port: 8080    │    │   Port: 8080     │    │   Port: 5432    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

## Prerequisites

### Required Software
- **Docker** (v20.10+) and **Docker Compose** (v2.0+)
- **Git** for source code management
- **curl** for health checks (optional)

### Database Setup
1. Create a **Supabase** account at https://supabase.com
2. Create a new project
3. Get your connection string from Project Settings → Database

## Quick Start (Docker)

### 1. Clone and Configure

```bash
# Clone the repository
git clone <repository-url>
cd galatasaray-management-system

# Create environment configuration
cp .env.example .env
```

### 2. Configure Environment Variables

Edit `.env` file with your settings:

```env
# Database Configuration (Required)
SUPABASE_CONNECTION_STRING=Server=your-supabase-host;Port=5432;Database=your-database;User Id=your-username;Password=your-password;

# Application Configuration
ASPNETCORE_ENVIRONMENT=Production
LOG_LEVEL=Information
ALLOWED_HOSTS=localhost,yourdomain.com
```

### 3. Deploy

**Linux/macOS:**
```bash
chmod +x deploy.sh
./deploy.sh
```

**Windows:**
```cmd
deploy.bat
```

### 4. Verify Deployment

- **Application**: http://localhost:8080
- **API Documentation**: http://localhost:8080/swagger
- **Health Check**: http://localhost:8080/health

## Manual Deployment

### 1. Build Docker Image

```bash
docker build -t galatasaray-management:latest .
```

### 2. Run Container

```bash
docker run -d \
  --name galatasaray-management \
  -p 8080:8080 \
  -e ConnectionStrings__DefaultConnection="your-connection-string" \
  -e ASPNETCORE_ENVIRONMENT=Production \
  galatasaray-management:latest
```

## Production Deployment

### 1. Reverse Proxy Setup (Nginx)

```nginx
server {
    listen 80;
    server_name yourdomain.com;
    
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### 2. SSL Certificate (Let's Encrypt)

```bash
sudo certbot --nginx -d yourdomain.com
```

### 3. Environment Variables for Production

```env
SUPABASE_CONNECTION_STRING=your-production-connection-string
ASPNETCORE_ENVIRONMENT=Production
LOG_LEVEL=Warning
ALLOWED_HOSTS=yourdomain.com
```

## Monitoring and Maintenance

### Health Checks

The application provides a health check endpoint:

```bash
curl http://localhost:8080/health
```

Expected response:
```json
{
  "status": "healthy",
  "timestamp": "2024-01-08T10:00:00Z",
  "version": "1.0.0",
  "service": "Galatasaray Management System"
}
```

### Logs

View application logs:
```bash
docker-compose logs -f galatasaray-api
```

### Updates

To update the application:
```bash
git pull origin main
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## Backup and Recovery

### Database Backup

```bash
# Backup (adjust connection details)
pg_dump -h your-supabase-host -U your-username -d your-database > backup.sql

# Restore
psql -h your-supabase-host -U your-username -d your-database < backup.sql
```

### Application Data

The application automatically creates seed data on startup:
- Galatasaray team and Rams Park stadium
- Legendary players (Hagi, Icardi, Muslera)
- Derby matches (Fenerbahçe, Beşiktaş, Trabzonspor)

## Troubleshooting

### Common Issues

1. **Port 8080 already in use**
   ```bash
   # Find process using port 8080
   lsof -i :8080
   # Kill the process or change port in docker-compose.yml
   ```

2. **Database connection failed**
   - Verify Supabase connection string
   - Check firewall settings
   - Ensure database is accessible

3. **Application won't start**
   ```bash
   # Check logs
   docker-compose logs galatasaray-api
   
   # Restart services
   docker-compose restart
   ```

4. **Static files not loading**
   - Verify wwwroot folder exists
   - Check file permissions
   - Ensure UseStaticFiles() is configured

### Performance Optimization

1. **Database Optimization**
   - Enable connection pooling
   - Add database indexes for frequently queried fields
   - Monitor query performance

2. **Application Optimization**
   - Enable response compression
   - Configure caching headers
   - Use CDN for static assets

3. **Container Optimization**
   - Adjust memory limits in docker-compose.yml
   - Use multi-stage builds (already implemented)
   - Monitor resource usage

## Security Considerations

### Production Security Checklist

- [ ] Use HTTPS in production
- [ ] Configure proper CORS settings
- [ ] Set secure connection strings
- [ ] Enable request rate limiting
- [ ] Configure proper logging levels
- [ ] Use secrets management for sensitive data
- [ ] Regular security updates
- [ ] Monitor for vulnerabilities

### Environment Variables Security

Never commit sensitive data to version control:
- Use `.env` files (excluded from git)
- Use container orchestration secrets
- Use cloud provider secret management

## API Documentation

Once deployed, access the interactive API documentation at:
- **Swagger UI**: http://localhost:8080/swagger

### Key Endpoints

- `GET /api/v1/players` - List all players
- `GET /api/v1/matches` - List all matches
- `GET /api/v1/matches/with-players` - Matches with player details
- `GET /api/v1/matches/{id}/players` - Specific match details
- `POST /api/v1/players` - Create new player
- `POST /api/v1/matches` - Create new match

## Support

For issues and questions:
1. Check the troubleshooting section above
2. Review application logs
3. Verify configuration settings
4. Check database connectivity

## System Requirements

### Minimum Requirements
- **CPU**: 1 vCPU
- **RAM**: 512 MB
- **Storage**: 1 GB
- **Network**: Internet connection for Supabase

### Recommended Requirements
- **CPU**: 2 vCPU
- **RAM**: 1 GB
- **Storage**: 5 GB
- **Network**: Stable internet connection

---

🎉 **Galatasaray Management System is ready for production!** ⚽

For additional support or feature requests, please refer to the project documentation.