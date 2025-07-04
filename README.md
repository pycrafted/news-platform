# News Platform

Plateforme complète de gestion, publication et consultation d’actualités.
Technos principales : **Spring Boot 3**, **React + Vite**, **PostgreSQL 14+**, **Flyway**, **JWT**.

---

## Sommaire rapide

1. Pré-requis
2. Mise en route (backend, base, frontend)
3. Variables d’environnement (`.env`)
4. Pièges fréquents & solutions
5. Scripts utiles

---

## 1. Pré-requis

| Outil          | Version mini | Pourquoi                             |
|----------------|--------------|--------------------------------------|
| Java JDK       | 17           | Spring Boot 3                        |
| PostgreSQL     | 14 +         | Fonctions `uuid` / `pg_trgm`         |
| Node + pnpm    | Node 18 +    | Frontend React                       |
| Flyway         | — (bundlé)  | Migrations auto au démarrage         |

> Debian / Ubuntu : `sudo apt install openjdk-17-jdk postgresql postgresql-contrib nodejs npm && npm i -g pnpm`

---

## 2. Mise en route

### 2.1. Cloner et préparer l’environnement

```bash
git clone https://github.com/noreyni03/news-platform.git
cd news-platform
cp .env.example .env 
```

### 2.2. Base de données locale

1. Démarrer PostgreSQL : `sudo systemctl start postgresql`
2. Créer l’utilisateur et la base :

```sql
CREATE ROLE newsuser WITH LOGIN PASSWORD 'G7!pR2@vLq8z';
CREATE DATABASE newsplatform OWNER newsuser;
```

3. Activer les extensions requises :

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
```

### 2.3. Lancer le backend

```bash
cd backend
./gradlew bootRun   # ➜ http://localhost:8080
```

### 2.4. Lancer le frontend

```bash
cd ../frontend
pnpm install
pnpm dev --host     # ➜ http://localhost:5173
```

---

## 3. Fichier `.env`

```env
# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=newsplatform
DB_USERNAME=newsuser
DB_PASSWORD=G7!pR2@vLq8z

# JWT
JWT_SECRET=change-me
JWT_EXPIRATION=86400000

# API
API_URL=http://localhost:8080/api
FRONTEND_URL=http://localhost:3000

# File Upload
UPLOAD_DIR=./uploads
MAX_FILE_SIZE=10MB

# SOAP
SOAP_ENDPOINT_URL=http://localhost:8080/ws
```

---

## 4. Pièges fréquents & solutions

| Problème                                      | Cause                                    | Correctif                                           |
|-----------------------------------------------|------------------------------------------|------------------------------------------------------|
| `UnknownHostException: db`                    | `DB_HOST` pointe vers `db` (docker)      | Mettre `localhost`                                   |
| `password authentication failed`              | Utilisateur / mot de passe non alignés   | `ALTER ROLE newsuser WITH PASSWORD '...'`            |
| `function uuid_generate_v4() does not exist`  | Extension `uuid-ossp` manquante          | `CREATE EXTENSION "uuid-ossp";`                     |
| Erreur SQL sur apostrophe                     | Apostrophe non échappée dans les INSERT  | Doubler `'` → `''`                                   |
| Port 8080 déjà pris                           | Service déjà actif                       | Définir `SERVER_PORT=8081` ou arrêter le service     |

---

## 5. Scripts utiles

```bash
./scripts/build-all.sh   # build complet (backend + frontend)

# Réinitialiser la DB et rejouer les migrations (⚠️ destructive)
psql -U newsuser -d newsplatform -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'
```

---

## 🛠️ Contribuer

1. Fork → branche → PR.
2. Exécuter `./gradlew test` et `pnpm lint` avant de pousser.

---

## 📄 Licence

MIT

---

**Contact / Support** : ouvrez une issue sur GitHub.

