#!/bin/bash

echo "🔧 Setting up development environment..."

# Copy environment files
cp .env.example .env.local
cp config/.env.dev .env

# Setup database
docker-compose up -d db
sleep 10

# Install dependencies
cd frontend && pnpm install && cd ..
cd backend && ./gradlew build -x test && cd ..

# Start services
docker-compose up -d

echo "✅ Development environment ready!"
echo "🌐 Frontend: http://localhost:3000"
echo "🔧 Backend: http://localhost:8080"
echo "📚 API Docs: http://localhost:8080/swagger-ui.html"