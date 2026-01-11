This is project java maven springboot mysql.

## Requirements

### Option 1: Traditional Setup
- IDE (VSCode, Eclipse, IntelliJ IDEA, etc.)
- Java JDK 17
- Apache Maven
- MySQL Server (or MySQL in XAMPP, database on phpMyAdmin)

### Option 2: Docker Setup (Recommended)
- Docker Desktop https://www.docker.com/
  - For Windows: Docker Desktop for Windows
  - For Mac: Docker Desktop for Mac
  - For Linux: Docker Engine

## Running the Application

### Using Docker Compose (All Platforms)

#### Windows (PowerShell or CMD):
```bash
# Build and start containers
docker-compose up -d --build

# Import database schema (first time only)
docker exec -i projectjavademo-mysql mysql -uroot -prootpassword shop_quan_ao < src/main/resources/db/shopbanquanao.sql

# Restart app container
docker restart projectjavademo

# View logs
docker-compose logs -f app

# Stop containers
docker-compose down
```

#### Linux/Mac (Terminal):
```bash
# Build and start containers
docker-compose up -d --build

# Import database schema (first time only)
docker exec -i projectjavademo-mysql mysql -uroot -prootpassword shop_quan_ao < src/main/resources/db/shopbanquanao.sql

# Restart app container
docker restart projectjavademo

# View logs
docker-compose logs -f app

# Stop containers
docker-compose down
```

### Using Maven (Traditional)
```bash
mvn clean install
mvn spring-boot:run
```

## Access the Application
Open browser and navigate to: http://localhost:8080
