#!/bin/bash

# Galatasaray Football Management System - Docker Deployment Script

set -e

echo "🔴🟡 Galatasaray Football Management System - Docker Deployment 🟡🔴"
echo "=================================================================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Creating from .env.example..."
    cp .env.example .env
    echo "📝 Please edit .env file with your configuration before running again."
    exit 1
fi

echo "🔧 Building Docker images..."
docker-compose build --no-cache

echo "🚀 Starting services..."
docker-compose up -d

echo "⏳ Waiting for services to be healthy..."
sleep 10

# Check if the application is running
if curl -f http://localhost:8080/health > /dev/null 2>&1; then
    echo "✅ Application is running successfully!"
    echo "🌐 Access the application at: http://localhost:8080"
    echo "📊 API documentation at: http://localhost:8080/swagger"
else
    echo "❌ Application failed to start. Checking logs..."
    docker-compose logs galatasaray-api
    exit 1
fi

echo ""
echo "🎉 Deployment completed successfully!"
echo ""
echo "📋 Useful commands:"
echo "   View logs:     docker-compose logs -f"
echo "   Stop services: docker-compose down"
echo "   Restart:       docker-compose restart"
echo "   Update:        ./deploy.sh"
echo ""
echo "⚽ Galatasaray Management System is ready!"