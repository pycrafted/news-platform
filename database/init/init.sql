-- Création de la base de données et de l'utilisateur
CREATE DATABASE newsplatform;
CREATE USER admin_9F8a7C WITH ENCRYPTED PASSWORD 'G7!pR2@vLq8z';
GRANT ALL PRIVILEGES ON DATABASE newsplatform TO admin_9F8a7C;

-- Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";