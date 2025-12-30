# Symfony Boilerplate - Symfony 7.4 & PHP 8.4 & PostgreSQL 17 & Node.js 22 - fast start for Your project

[![PHP Version](https://img.shields.io/badge/PHP-8.4-777BB4?style=flat&logo=php)](https://www.php.net/)
[![Symfony Version](https://img.shields.io/badge/Symfony-7.4-000000?style=flat&logo=symfony)](https://symfony.com/)
[![PostgreSQL Version](https://img.shields.io/badge/PostgreSQL-17-336791?style=flat&logo=postgresql)](https://www.postgresql.org/)
[![Node.js Version](https://img.shields.io/badge/Node.js-22-339933?style=flat&logo=node.js)](https://nodejs.org/)
[![Doctrine ORM](https://img.shields.io/badge/Doctrine_ORM-3.3-FC6D26?style=flat)](https://www.doctrine-project.org/)
[![PHPStan Level](https://img.shields.io/badge/PHPStan-Level_8-4C1?style=flat)](https://phpstan.org/)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat)](LICENSE)

A modern Docker-based Symfony boilerplate with PHP 8.4, Symfony 7.4, PostgreSQL 17, and the latest frontend tooling.

## 🚀 Actual Version (December 2025)

This boilerplate has been updated to use:
- **Symfony 7.4** (latest stable)
- **PHP 8.4** (latest stable)
- **PostgreSQL 17** (latest stable)
- **Node.js 22** (latest LTS)
- **Doctrine ORM 3.3** (latest stable)
- **Bootstrap 5.3.3** (latest)
- **Webpack Encore 5.0** (latest)
- **EasyAdmin 4.15** (latest)
- **Xdebug 3.x** (latest)
- **PHPUnit 11.5** (latest)
- **PHPStan 2.0** (latest)

## 📦 What's Included

### Backend
- Symfony 7.4 Framework
- PHP 8.4-FPM
- Doctrine ORM 3.3 with PostgreSQL 17
- EasyAdmin 4.15 for quick admin interfaces
- Xdebug 3.x support (configurable)

### Frontend
- Webpack Encore 5.0
- Bootstrap 5.3.3
- Modern JavaScript with Babel
- Sass support (Dart Sass)

### Development Tools
- Nginx (latest Alpine)
- MailHog for email testing
- Docker Compose for orchestration
- PHPUnit 11.5 for testing
- PHPStan 2.0 for static analysis

## 🛠️ Installation

### Prerequisites
- [Docker & Docker Compose](https://docs.docker.com/get-docker/) - Container platform
- [Git](https://git-scm.com/downloads) - Version control system

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/michallkanak/symfony-boilerplate.git
   cd symfony-boilerplate
   ```

2. **Install everything with one command**
   ```bash
   make install
   ```
   
   This will:
   - Build all Docker containers
   - Start all services
   - Install PHP and npm dependencies
   - Build frontend assets
   - Run database migrations

3. **Access the application**
   - Application: http://localhost
   - Admin: http://localhost/admin
   - MailHog: http://localhost:8025

### Alternative: Manual Installation

If you prefer to run commands step by step:

1. **Clone the repository**
   ```bash
   git clone https://github.com/michallkanak/symfony-boilerplate.git
   cd symfony-boilerplate
   ```

2. **Build and start Docker containers**
   ```bash
   docker compose build
   docker compose up -d
   ```

3. **Install PHP dependencies**
   ```bash
   docker compose exec php-fpm composer install
   ```

4. **Install frontend dependencies**
   ```bash
   docker compose exec encore npm install
   ```

5. **Build assets**
   ```bash
   docker compose exec encore npm run build
   ```

6. **Run database migrations**
   ```bash
   docker compose exec php-fpm bin/console doctrine:migrations:migrate --no-interaction
   ```

7. **Access the application**
   - Application: http://localhost
   - Admin: http://localhost/admin
   - MailHog: http://localhost:8025

## 🔧 Configuration

### Makefile Commands

This project includes a Makefile for easier development. Common commands:

```bash
# Show all available commands
make help

# Fresh installation
make install

# Start containers
make up

# Stop containers
make down

# Run tests
make test

# Run PHPStan
make phpstan

# Access PHP shell
make php-shell

# Build frontend assets
make npm-build

# Watch frontend changes
make npm-watch
```

### Environment Variables
Copy `.env` and adjust as needed for your environment.

Key variables:
- `APP_ENV` - Application environment (dev/prod)
- `APP_SECRET` - Secret for CSRF tokens
- `DATABASE_URL` - PostgreSQL connection string

## 🔐 Admin Panel & Authentication

### Accessing the Admin Panel

The project includes **EasyAdmin** for quick administration interface:

- **Admin URL**: `http://localhost/admin`
- **Login URL**: `http://localhost/admin/login`

### Creating Admin User

Create your first admin user using the CLI command:

```bash
# Using Makefile
make php-shell
bin/console app:create-admin admin@example.com SecurePassword123

# Or directly
docker compose exec php-fpm bin/console app:create-admin admin@example.com SecurePassword123
```

**Command syntax:**
```bash
bin/console app:create-admin <email> <password>
```

The command will:
- ✅ Create a new user with `ROLE_ADMIN`
- ✅ Hash the password securely
- ✅ Check for duplicate emails
- ✅ Save to database

### User Management in EasyAdmin

Once logged in, you can manage users through the admin panel:

- **View users**: Browse all registered users
- **Create users**: Add new users with email and password
- **Edit users**: Update user information and roles
- **Assign roles**: 
  - `ROLE_USER` - Basic user role (automatically assigned)
  - `ROLE_ADMIN` - Administrator with full access

### Security Features

#### Login Rate Limiter

The login form is protected against brute-force attacks:

- **Maximum attempts**: 5 failed login attempts
- **Time window**: 15 minutes
- **Scope**: Per IP address
- **Protection**: Automatic throttling after limit is reached

After 5 failed login attempts from the same IP, users must wait 15 minutes before trying again.

#### Other Security Features

- ✅ **CSRF Protection**: All forms include CSRF tokens
- ✅ **Password Hashing**: Automatic password hashing using Symfony's best practices
- ✅ **Session-based Authentication**: Secure session management
- ✅ **Access Control**: `/admin` routes require `ROLE_ADMIN`

### Xdebug
To enable Xdebug, rebuild the PHP container with:
```bash
docker-compose build --build-arg DOCKER_PHP_ENABLE_XDEBUG=on php-fpm
docker-compose up -d php-fpm
```

Xdebug 3.x is configured with:
- Mode: debug
- Client host: host.docker.internal
- Client port: 9003
- IDE key: PHPSTORM

## 📝 Development

### Running Development Server
```bash
# Watch and rebuild assets on change
docker-compose exec encore npm run watch

# Dev server with hot reload
docker-compose exec encore npm run dev-server
```

### Database Commands
```bash
# Create a new migration
docker-compose exec php-fpm bin/console make:migration

# Run migrations
docker-compose exec php-fpm bin/console doctrine:migrations:migrate

# Load fixtures (if configured)
docker-compose exec php-fpm bin/console doctrine:fixtures:load
```

### Useful Symfony Commands
```bash
# Clear cache
docker-compose exec php-fpm bin/console cache:clear

# List all routes
docker-compose exec php-fpm bin/console debug:router

# Create a new controller
docker-compose exec php-fpm bin/console make:controller

# Create a new entity
docker-compose exec php-fpm bin/console make:entity
```

## 🧪 Testing & Code Quality

### Running Tests with PHPUnit

```bash
# Install/update dependencies first (if not already done)
docker-compose exec php-fpm composer update

# Run all tests
docker-compose exec php-fpm vendor/bin/phpunit

# Run tests with coverage
docker-compose exec php-fpm vendor/bin/phpunit --coverage-html var/coverage

# Run specific test file
docker-compose exec php-fpm vendor/bin/phpunit tests/ApplicationAvailabilityTest.php

# Run tests in a specific directory
docker-compose exec php-fpm vendor/bin/phpunit tests/Unit
```

### Static Analysis with PHPStan

```bash
# Run PHPStan analysis
docker-compose exec php-fpm vendor/bin/phpstan analyse

# Run with specific level (0-9)
docker-compose exec php-fpm vendor/bin/phpstan analyse --level 8

# Generate baseline (ignore current errors)
docker-compose exec php-fpm vendor/bin/phpstan analyse --generate-baseline

# Clear result cache
docker-compose exec php-fpm vendor/bin/phpstan clear-result-cache
```

### Code Quality Best Practices

- **PHPStan Level**: Currently set to level 8 (strictest)
- **Test Coverage**: Generate coverage reports to ensure code quality

## 🐳 Docker Services

| Service | Container Name | Port | Description |
|---------|---------------|------|-------------|
| nginx | sb-nginx | 80, 443 | Web server |
| php-fpm | sb-php-fpm | 9000 | PHP 8.4 FPM |
| db | sb-db | 15432 | PostgreSQL 17 |
| mailhog | sb-mailhog | 1025, 8025 | Email testing |
| encore | sb-encore | - | Frontend build tool |

## 📚 Additional Resources

- [Symfony Documentation](https://symfony.com/doc/current/index.html)
- [Doctrine ORM 3 Documentation](https://www.doctrine-project.org/projects/doctrine-orm/en/3.3/index.html)
- [EasyAdmin Documentation](https://symfony.com/bundles/EasyAdminBundle/current/index.html)
- [Webpack Encore Documentation](https://symfony.com/doc/current/frontend.html)

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This project is licensed under the [MIT License](LICENSE).
