# Fichier: backend/Dockerfile
# --- ÉTAPE 1: BUILD ---
# On utilise une image contenant Gradle et le JDK pour construire notre application
FROM gradle:8.5.0-jdk17-alpine AS build

# On définit le répertoire de travail
WORKDIR /home/gradle/src

# On copie d'abord les fichiers de build pour profiter du cache Docker
COPY build.gradle settings.gradle ./
COPY gradle gradle/
COPY gradlew ./

# On télécharge les dépendances (étape mise en cache)
RUN gradle dependencies --no-daemon

# On copie tout le code source
COPY src ./src

# On lance la commande de build pour créer le JAR exécutable, en sautant les tests
RUN gradle bootJar --no-daemon

# --- ÉTAPE 2: RUN ---
# On utilise une image Java beaucoup plus légère et sécurisée pour l'exécution
FROM openjdk:17-jre-slim

# On installe les dépendances nécessaires et on nettoie
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# On crée un utilisateur non-root pour la sécurité
RUN addgroup --system --gid 1001 appgroup && \
    adduser --system --uid 1001 --gid 1001 --no-create-home appuser

# On définit le répertoire de travail
WORKDIR /app

# On copie SEULEMENT le JAR construit depuis l'étape précédente
COPY --from=build /home/gradle/src/build/libs/*.jar app.jar

# On change le propriétaire du fichier
RUN chown appuser:appgroup app.jar

# On bascule vers l'utilisateur non-root
USER appuser

# On expose le port sur lequel l'application tourne
EXPOSE 8080

# Configuration JVM optimisée pour les containers
ENV JAVA_OPTS="-Xmx512m -Xms256m -XX:+UseG1GC -XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

# Utilisation de la variable PORT pour Render
ENV PORT=8080

# La commande pour lancer l'application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=$PORT -jar app.jar"]