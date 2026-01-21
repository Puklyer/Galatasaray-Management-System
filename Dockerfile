# Multi-stage Dockerfile for Galatasaray Football Management System
# Optimized for .NET 8 application with minimal image size

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project files for dependency resolution
COPY ["src/GalatasaraySystem.API/GalatasaraySystem.API.csproj", "src/GalatasaraySystem.API/"]
COPY ["src/GalatasaraySystem.Application/GalatasaraySystem.Application.csproj", "src/GalatasaraySystem.Application/"]
COPY ["src/GalatasaraySystem.Domain/GalatasaraySystem.Domain.csproj", "src/GalatasaraySystem.Domain/"]
COPY ["src/GalatasaraySystem.Infrastructure/GalatasaraySystem.Infrastructure.csproj", "src/GalatasaraySystem.Infrastructure/"]

# Restore dependencies
RUN dotnet restore "src/GalatasaraySystem.API/GalatasaraySystem.API.csproj"

# Copy all source code
COPY . .

# Build the application
WORKDIR "/src/src/GalatasaraySystem.API"
RUN dotnet build "GalatasaraySystem.API.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "GalatasaraySystem.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# Create non-root user for security
RUN adduser --disabled-password --gecos '' appuser && chown -R appuser /app
USER appuser

# Copy published application
COPY --from=publish /app/publish .

# Configure environment
ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_HTTP_PORTS=8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# Expose port
EXPOSE 8080

# Set entry point
ENTRYPOINT ["dotnet", "GalatasaraySystem.API.dll"]