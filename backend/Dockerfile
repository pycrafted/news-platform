# Fichier: backend/Dockerfile
# --- ÉTAPE 1: BUILD ---
    FROM gradle:8.5.0-jdk17-alpine AS build

    WORKDIR /home/gradle/src
    
    # Copie des fichiers de configuration
    COPY build.gradle settings.gradle ./
    
    # Téléchargement des dépendances (mise en cache)
    RUN gradle dependencies --no-daemon
    
    # Copie du code source
    COPY src ./src
    
    # Build de l'application
    RUN gradle bootJar --no-daemon
    
    # --- ÉTAPE 2: RUN ---
    FROM eclipse-temurin:17-jre-alpine
    
    # Installation des dépendances nécessaires
    RUN apk add --no-cache \
        ca-certificates \
        && rm -rf /var/cache/apk/*
    
    # Création d'un utilisateur non-root
    RUN addgroup -g 1001 -S appgroup && \
        adduser -u 1001 -S appuser -G appgroup
    
    WORKDIR /app
    
    # Copie du JAR depuis l'étape de build
    COPY --from=build /home/gradle/src/build/libs/*.jar app.jar
    
    # Changement du propriétaire
    RUN chown appuser:appgroup app.jar
    
    # Basculement vers l'utilisateur non-root
    USER appuser
    
    # Exposition du port
    EXPOSE 8080
    
    # Configuration JVM
    ENV JAVA_OPTS="-Xmx512m -Xms256m -XX:+UseG1GC -XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"
    ENV PORT=8080
    
    # Commande de démarrage
    ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=$PORT -jar app.jar"]