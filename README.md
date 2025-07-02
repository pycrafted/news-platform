# News Platform

Plateforme complète de gestion, publication et consultation d'actualités, pensée pour la modularité, la sécurité et la performance.  
**Repo GitHub : [noreyni03/news-platform](https://github.com/noreyni03/news-platform.git)**

## Sommaire

- [Présentation](#présentation)
- [Fonctionnalités](#fonctionnalités)
- [Architecture & Structure du projet](#architecture--structure-du-projet)
- [Technologies utilisées](#technologies-utilisées)
- [Installation & Démarrage](#installation--démarrage)
- [Scripts utiles](#scripts-utiles)
- [Déploiement](#déploiement)
- [Contribuer](#contribuer)
- [Licence](#licence)

---

## Présentation

**News Platform** est une application web moderne permettant la gestion collaborative d'articles d'actualité, avec une interface web, une API REST/Soap, et un client desktop.  
Elle s'appuie sur une architecture microservices (backend, frontend, base de données, client desktop) orchestrée via Docker.

---

## Fonctionnalités

- Authentification et gestion des utilisateurs (rôles : admin, user)
- Gestion des articles (création, édition, publication, brouillons)
- Catégorisation des articles
- API REST et SOAP pour l'intégration externe
- Interface web moderne (React + Vite + TailwindCSS)
- Client desktop JavaFX
- Historique et audit des actions
- Système de tokens JWT pour la sécurité
- Scripts d'initialisation et de seed de la base de données
- Prise en charge du développement local via Docker Compose

---

## Architecture & Structure du projet

```
news-platform/
│
├── backend/         # API Spring Boot (REST & SOAP)
│   └── src/main/java/com/newsplatform/
│
├── frontend/        # Application web React (Vite, TypeScript, TailwindCSS)
│   └── src/
│
├── desktop-client/  # Client desktop JavaFX
│   └── newsplatformdesktopclient/
│
├── database/        # Scripts d'init, seeds, backup pour PostgreSQL
│
├── integration/     # Tests d'intégration (Cypress)
│
├── scripts/         # Scripts d'automatisation (build, setup, etc.)
│
├── docker-compose.yml
└── README.md
```

---

## Technologies utilisées

- **Backend** : Java 17, Spring Boot 3, Spring Security, JPA/Hibernate, Flyway, PostgreSQL, Lombok
- **Frontend** : React 19, Vite, TypeScript, TailwindCSS, Redux Toolkit, Axios, Yup, Heroicons
- **Client Desktop** : JavaFX 17, ControlsFX, FormsFX, TilesFX, BootstrapFX
- **Base de données** : PostgreSQL 15, extensions uuid-ossp & pg_trgm
- **Tests** : JUnit 5, Cypress
- **Outils & DevOps** : Docker, Docker Compose, Gradle, pnpm

---

## Installation & Démarrage

### Prérequis

- [Docker](https://www.docker.com/)
- [pnpm](https://pnpm.io/) (pour le frontend)
- [Java 17+](https://adoptium.net/) (pour le backend et le client desktop)

### Démarrage rapide (en local)

1. **Cloner le dépôt :**
   ```bash
   git clone https://github.com/noreyni03/news-platform.git
   cd news-platform
   ```

2. **Configurer les variables d'environnement :**
   - Copier `.env.example` en `.env` à la racine et adapter si besoin.

3. **Lancer l'environnement de développement :**
   ```bash
   ./scripts/setup-dev.sh
   ```
   Cela va :
   - Initialiser la base PostgreSQL (via Docker)
   - Installer les dépendances frontend/backend
   - Builder le backend et le client desktop
   - Démarrer tous les services (API, frontend, DB)

4. **Accéder aux services :**
   - Frontend : [http://localhost:3000](http://localhost:3000)
   - Backend : [http://localhost:8080](http://localhost:8080)
   - Documentation API : [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)

---

## Scripts utiles

- `./scripts/setup-dev.sh` : setup complet pour le dev local
- `./scripts/build-all.sh` : build de tous les modules
- `docker-compose up -d` : démarrage manuel des services
- `docker-compose down` : arrêt des services

---

## Déploiement

Le projet est prêt pour un déploiement sur tout environnement supportant Docker.  
Adapter les variables d'environnement selon la cible (voir `docker-compose.yml` et les fichiers `.env`).

---

## Contribuer

1. Forkez le repo, créez une branche, proposez une PR.
2. Respectez la structure du projet et les conventions de code.
3. Ajoutez des tests pour toute nouvelle fonctionnalité.

---

## Licence

Ce projet est sous licence MIT.

---

**Contact & Documentation :**  
Voir la documentation technique dans le dossier [`/docs`](./docs) pour plus de détails sur l'API, l'architecture et le déploiement.

---

*Généré automatiquement à partir de l'analyse du code source.*
