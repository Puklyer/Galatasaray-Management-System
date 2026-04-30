# 🔴🟡 Galatasaray Football Management System 🟡🔴
<img width="1919" height="1079" alt="Ekran görüntüsü 2026-04-30 180449" src="https://github.com/user-attachments/assets/47060ad0-f362-419b-b7b1-407b110d8250" />
<img width="1919" height="1079" alt="Ekran görüntüsü 2026-04-30 180510" src="https://github.com/user-attachments/assets/b642d754-af22-4f03-a246-c94535e9325e" />
<img width="1919" height="413" alt="Ekran görüntüsü 2026-04-30 180520" src="https://github.com/user-attachments/assets/654f988f-da64-4828-925b-5d09860e14a4" />

A comprehensive football management system built with .NET 8, featuring a responsive web interface and RESTful API for managing Galatasaray players, matches, and statistics.

## ✨ Features

### 🏟️ **Complete Team Management**
- **Player Management**: Full CRUD operations for player data
- **Match Management**: Schedule and track matches with detailed statistics
- **Player-Match Associations**: Track player participation and minutes played
- **Seed Data**: Pre-loaded with Galatasaray team, Rams Park stadium, and legendary players

### 🎨 **Modern Web Interface**
- **Responsive Design**: Optimized for desktop (4-column grid) and mobile (single-column)
- **Galatasaray Branding**: Official colors (Red #CC0000, Yellow #FFCC00)
- **Interactive UI**: Dynamic match selection and player details modal
- **Real-time Updates**: AJAX-powered content loading without page refresh

### 🏗️ **Enterprise Architecture**
- **Clean Architecture**: Domain, Application, Infrastructure, and API layers
- **RESTful API**: Comprehensive endpoints with Swagger documentation
- **Entity Framework Core**: PostgreSQL integration with Supabase
- **Property-Based Testing**: 100+ test iterations for reliability
- **Docker Ready**: Multi-stage containerization for easy deployment

## 🚀 Quick Start

### Prerequisites
- **Docker** and **Docker Compose**
- **Supabase** account (for PostgreSQL database)

### 1. Clone and Configure
```bash
git clone <repository-url>
cd galatasaray-management-system
cp .env.example .env
```

### 2. Set Up Database
1. Create a Supabase project at https://supabase.com
2. Get your connection string from Project Settings → Database
3. Update `.env` with your connection string

### 3. Deploy
```bash
# Linux/macOS
./deploy.sh

# Windows
deploy.bat
```

### 4. Access Application
- **Web Interface**: http://localhost:8080
- **API Documentation**: http://localhost:8080/swagger
- **Health Check**: http://localhost:8080/health

## 📊 API Endpoints

### Players
- `GET /api/v1/players` - List all players
- `GET /api/v1/players/{id}` - Get player details
- `POST /api/v1/players` - Create new player
- `PUT /api/v1/players/{id}` - Update player
- `DELETE /api/v1/players/{id}` - Delete player

### Matches
- `GET /api/v1/matches` - List all matches (chronological)
- `GET /api/v1/matches/with-players` - Matches with player details
- `GET /api/v1/matches/recent?count=10` - Recent matches
- `GET /api/v1/matches/date-range` - Matches by date range
- `GET /api/v1/matches/{id}/players` - Match with player details
- `POST /api/v1/matches` - Create new match
- `PUT /api/v1/matches/{id}` - Update match
- `DELETE /api/v1/matches/{id}` - Delete match

### Player-Match Associations
- `GET /api/v1/playermatches` - List all player-match records
- `POST /api/v1/playermatches` - Assign player to match
- `PUT /api/v1/playermatches/{id}` - Update assignment
- `DELETE /api/v1/playermatches/{id}` - Remove assignment

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  ┌─────────────────┐    ┌─────────────────────────────────┐ │
│  │   Frontend      │    │        API Controllers          │ │
│  │   (Tailwind)    │    │     (RESTful Endpoints)         │ │
│  └─────────────────┘    └─────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                    │
┌─────────────────────────────────────────────────────────────┐
│                   Application Layer                          │
│  ┌─────────────────┐    ┌─────────────────────────────────┐ │
│  │   Services      │    │            DTOs                 │ │
│  │ (Business Logic)│    │      (Data Transfer)            │ │
│  └─────────────────┘    └─────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                    │
┌─────────────────────────────────────────────────────────────┐
│                  Infrastructure Layer                        │
│  ┌─────────────────┐    ┌─────────────────────────────────┐ │
│  │  Repositories   │    │        Entity Framework        │ │
│  │ (Data Access)   │    │      (PostgreSQL/Supabase)     │ │
│  └─────────────────┘    └─────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                    │
┌─────────────────────────────────────────────────────────────┐
│                     Domain Layer                             │
│  ┌─────────────────┐    ┌─────────────────────────────────┐ │
│  │    Entities     │    │        Business Rules          │ │
│  │ (Core Models)   │    │      (Domain Logic)             │ │
│  └─────────────────┘    └─────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## 🧪 Testing

### Test Coverage
- **12 Property-Based Tests**: Universal correctness properties (100+ iterations each)
- **24 Unit Tests**: Specific scenarios and edge cases
- **8 Integration Tests**: End-to-end workflow validation
- **Total**: 44 comprehensive tests

### Key Test Categories
- **Data Persistence & Integrity**: Round-trip validation, referential integrity
- **Business Logic**: Player double-booking prevention, input validation
- **API Consistency**: Response format, error handling, JSON structure
- **UI Functionality**: Match selection, responsive design, mobile compatibility
- **Docker Deployment**: Health checks, environment configuration

### Running Tests
```bash
# Run all tests
dotnet test

# Run specific test category
dotnet test --filter "Category=PropertyTests"
dotnet test --filter "Category=UnitTests"
dotnet test --filter "Category=IntegrationTests"
```

## 🛠️ Development

### Project Structure
```
src/
├── GalatasaraySystem.API/          # Web API and Frontend
├── GalatasaraySystem.Application/  # Business Logic
├── GalatasaraySystem.Domain/       # Core Entities
└── GalatasaraySystem.Infrastructure/ # Data Access

tests/
└── GalatasaraySystem.Tests/
    ├── PropertyTests/              # Property-based tests
    ├── UnitTests/                  # Unit tests
    └── IntegrationTests/           # End-to-end tests
```

### Key Technologies
- **.NET 8**: Latest LTS framework
- **Entity Framework Core**: ORM with PostgreSQL
- **Tailwind CSS**: Utility-first CSS framework
- **FsCheck**: Property-based testing library
- **xUnit**: Unit testing framework
- **Docker**: Containerization platform
- **Supabase**: PostgreSQL hosting platform

## 🔧 Configuration

### Environment Variables
```env
# Database (Required)
SUPABASE_CONNECTION_STRING=Server=host;Port=5432;Database=db;User Id=user;Password=pass;

# Application
ASPNETCORE_ENVIRONMENT=Production
LOG_LEVEL=Information
ALLOWED_HOSTS=localhost,yourdomain.com
```

### Docker Configuration
- **Port**: 8080 (configurable)
- **Health Checks**: Built-in endpoint monitoring
- **Multi-stage Build**: Optimized image size
- **Security**: Non-root user execution

## 📈 Business Features

### Critical Business Rules
- **Player Double-Booking Prevention**: Players cannot be assigned to multiple matches on the same date
- **Input Validation**: Comprehensive validation for all user inputs
- **Audit Logging**: All critical operations are logged for compliance
- **Referential Integrity**: Database constraints ensure data consistency

### Seed Data
The system automatically loads:
- **Galatasaray Team** with Rams Park stadium (52,280 capacity)
- **Legendary Players**: Gheorghe Hagi, Mauro Icardi, Fernando Muslera
- **Derby Matches**: Historical matches against Fenerbahçe and Beşiktaş

## 🚀 Deployment Options

### 1. Docker (Recommended)
```bash
docker-compose up -d
```

### 2. Manual .NET Deployment
```bash
dotnet publish -c Release
dotnet GalatasaraySystem.API.dll
```

### 3. Cloud Deployment
- **Azure Container Instances**
- **AWS ECS/Fargate**
- **Google Cloud Run**
- **DigitalOcean App Platform**

## 📚 Documentation

- **[Deployment Guide](DEPLOYMENT.md)**: Complete production deployment instructions
- **[API Documentation](http://localhost:8080/swagger)**: Interactive API explorer
- **[Test Summary](tests/GalatasaraySystem.Tests/TestSummary.md)**: Comprehensive test coverage report

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🏆 Acknowledgments

- **Galatasaray Spor Kulübü** for inspiration
- **Clean Architecture** principles by Robert C. Martin
- **Property-Based Testing** methodology
- **Tailwind CSS** for responsive design framework

---

**🔴🟡 Cimbom! 🟡🔴**

*Built with ❤️ for Galatasaray fans worldwide*
