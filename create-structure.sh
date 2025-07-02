#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# create-structure.sh
# -----------------------------------------------------------------------------
# Ce script crée (ou vérifie l'existence de) tous les dossiers et fichiers
# mentionnés dans l'arborescence du projet News Platform, à l'exception de la
# partie `desktop-client`.  Il peut être exécuté autant de fois que souhaité ;
# il est idempotent : si un dossier ou un fichier existe déjà il n'est pas 
# modifié.
# -----------------------------------------------------------------------------
set -euo pipefail

# Liste exhaustive des fichiers à créer.
# IMPORTANT : n'incluez aucun élément relatif à `desktop-client/`.
files=(
  # Racine
  "README.md"
  ".gitignore"
  "docker-compose.yml"
  ".env.example"
  ".env.local"

  # Backend
  "backend/build.gradle"
  "backend/Dockerfile"

  # Backend – Java source
  "backend/src/main/java/com/newsplatform/NewsplatformApplication.java"
  "backend/src/main/java/com/newsplatform/aspect/LoggingAspect.java"
  "backend/src/main/java/com/newsplatform/aspect/SecurityAspect.java"
  "backend/src/main/java/com/newsplatform/cache/CacheConfig.java"
  "backend/src/main/java/com/newsplatform/config/SecurityConfig.java"
  "backend/src/main/java/com/newsplatform/config/WebConfig.java"
  "backend/src/main/java/com/newsplatform/config/JwtConfig.java"
  "backend/src/main/java/com/newsplatform/config/SwaggerConfig.java"
  "backend/src/main/java/com/newsplatform/config/SoapConfig.java"

  # Controllers
  "backend/src/main/java/com/newsplatform/controller/rest/ArticleController.java"
  "backend/src/main/java/com/newsplatform/controller/rest/CategoryController.java"
  "backend/src/main/java/com/newsplatform/controller/rest/UserController.java"
  "backend/src/main/java/com/newsplatform/controller/rest/AuthController.java"
  "backend/src/main/java/com/newsplatform/controller/web/WebController.java"

  # SOAP Endpoints
  "backend/src/main/java/com/newsplatform/soap/UserEndpoint.java"
  "backend/src/main/java/com/newsplatform/soap/AuthEndpoint.java"

  # Entities
  "backend/src/main/java/com/newsplatform/entity/User.java"
  "backend/src/main/java/com/newsplatform/entity/Article.java"
  "backend/src/main/java/com/newsplatform/entity/Category.java"
  "backend/src/main/java/com/newsplatform/entity/AuthToken.java"
  "backend/src/main/java/com/newsplatform/entity/RefreshToken.java"
  "backend/src/main/java/com/newsplatform/entity/AuditLog.java"

  # Exceptions
  "backend/src/main/java/com/newsplatform/exception/GlobalExceptionHandler.java"
  "backend/src/main/java/com/newsplatform/exception/ResourceNotFoundException.java"
  "backend/src/main/java/com/newsplatform/exception/AuthenticationException.java"

  # Mapper
  "backend/src/main/java/com/newsplatform/mapper/UserMapper.java"
  "backend/src/main/java/com/newsplatform/mapper/ArticleMapper.java"
  "backend/src/main/java/com/newsplatform/mapper/CategoryMapper.java"

  # Repositories
  "backend/src/main/java/com/newsplatform/repository/UserRepository.java"
  "backend/src/main/java/com/newsplatform/repository/ArticleRepository.java"
  "backend/src/main/java/com/newsplatform/repository/CategoryRepository.java"
  "backend/src/main/java/com/newsplatform/repository/AuthTokenRepository.java"
  "backend/src/main/java/com/newsplatform/repository/RefreshTokenRepository.java"
  "backend/src/main/java/com/newsplatform/repository/AuditLogRepository.java"

  # Services
  "backend/src/main/java/com/newsplatform/service/UserService.java"
  "backend/src/main/java/com/newsplatform/service/ArticleService.java"
  "backend/src/main/java/com/newsplatform/service/CategoryService.java"
  "backend/src/main/java/com/newsplatform/service/AuthService.java"
  "backend/src/main/java/com/newsplatform/service/AuditService.java"
  "backend/src/main/java/com/newsplatform/service/FileStorageService.java"

  # DTOs
  "backend/src/main/java/com/newsplatform/dto/request/LoginRequest.java"
  "backend/src/main/java/com/newsplatform/dto/request/ArticleRequest.java"
  "backend/src/main/java/com/newsplatform/dto/request/CategoryRequest.java"
  "backend/src/main/java/com/newsplatform/dto/request/UserRequest.java"
  "backend/src/main/java/com/newsplatform/dto/response/AuthResponse.java"
  "backend/src/main/java/com/newsplatform/dto/response/ArticleResponse.java"
  "backend/src/main/java/com/newsplatform/dto/response/CategoryResponse.java"
  "backend/src/main/java/com/newsplatform/dto/response/UserResponse.java"

  # Sécurité
  "backend/src/main/java/com/newsplatform/security/JwtAuthenticationEntryPoint.java"
  "backend/src/main/java/com/newsplatform/security/JwtAuthenticationFilter.java"
  "backend/src/main/java/com/newsplatform/security/JwtTokenProvider.java"
  "backend/src/main/java/com/newsplatform/security/UserPrincipal.java"

  # Utils & Validators
  "backend/src/main/java/com/newsplatform/util/AuditUtil.java"
  "backend/src/main/java/com/newsplatform/util/FileUtil.java"
  "backend/src/main/java/com/newsplatform/validator/StrongPasswordValidator.java"
  "backend/src/main/java/com/newsplatform/validator/UniqueUsernameValidator.java"

  # Backend – Resources
  "backend/src/main/resources/application.yml"
  "backend/src/main/resources/application-dev.yml"
  "backend/src/main/resources/application-staging.yml"
  "backend/src/main/resources/application-prod.yml"
  "backend/src/main/resources/db/migration/V1__Initial_Schema.sql"
  "backend/src/main/resources/db/migration/V2__Add_Sample_Data.sql"
  "backend/src/main/resources/wsdl/users.wsdl"

  # Backend – Tests
  "backend/src/test/java/com/newsplatform/controller/ArticleControllerTest.java"
  "backend/src/test/java/com/newsplatform/service/UserServiceTest.java"
  "backend/src/test/java/com/newsplatform/repository/UserRepositoryTest.java"
  "backend/src/test/resources/application-test.yml"

  # Config env
  "config/.env.dev"
  "config/.env.staging"
  "config/.env.prod"

  # Database
  "database/init/init.sql"
  "database/seeds/sample-data.sql"
  "database/backup/backup-script.sh"

  # Frontend root
  "frontend/package.json"
  "frontend/pnpm-lock.yaml"
  "frontend/vite.config.js"
  "frontend/tailwind.config.js"
  "frontend/postcss.config.js"
  "frontend/Dockerfile.dev"
  "frontend/index.html"
  "frontend/.eslintrc.cjs"

  # Frontend source
  "frontend/src/main.jsx"
  "frontend/src/App.jsx"

  # Frontend – components/common
  "frontend/src/components/common/Header.jsx"
  "frontend/src/components/common/Footer.jsx"
  "frontend/src/components/common/Loading.jsx"
  "frontend/src/components/common/InfiniteScroll.jsx"
  "frontend/src/components/common/Button.jsx"

  # Frontend – components/auth
  "frontend/src/components/auth/LoginForm.jsx"
  "frontend/src/components/auth/ProtectedRoute.jsx"

  # Frontend – components/articles
  "frontend/src/components/articles/ArticleList.jsx"
  "frontend/src/components/articles/ArticleCard.jsx"
  "frontend/src/components/articles/ArticleDetail.jsx"
  "frontend/src/components/articles/ArticleForm.jsx"
  "frontend/src/components/articles/ArticleSearch.jsx"

  # Frontend – components/categories
  "frontend/src/components/categories/CategoryList.jsx"
  "frontend/src/components/categories/CategoryTree.jsx"
  "frontend/src/components/categories/CategoryForm.jsx"

  # Frontend – components/admin
  "frontend/src/components/admin/Dashboard.jsx"
  "frontend/src/components/admin/UserManagement.jsx"
  "frontend/src/components/admin/TokenManagement.jsx"
  "frontend/src/components/admin/AuditLogs.jsx"

  # Frontend – components/editor
  "frontend/src/components/editor/EditorDashboard.jsx"

  # Frontend – pages
  "frontend/src/pages/HomePage.jsx"
  "frontend/src/pages/ArticlePage.jsx"
  "frontend/src/pages/CategoryPage.jsx"
  "frontend/src/pages/LoginPage.jsx"
  "frontend/src/pages/AdminPage.jsx"
  "frontend/src/pages/EditorPage.jsx"
  "frontend/src/pages/NotFoundPage.jsx"

  # Frontend – Stores
  "frontend/src/store/authStore.js"
  "frontend/src/store/articleStore.js"
  "frontend/src/store/categoryStore.js"
  "frontend/src/store/userStore.js"

  # Frontend – Services
  "frontend/src/services/api.js"
  "frontend/src/services/authService.js"
  "frontend/src/services/articleService.js"
  "frontend/src/services/categoryService.js"
  "frontend/src/services/userService.js"

  # Frontend – Hooks
  "frontend/src/hooks/useAuth.js"
  "frontend/src/hooks/useInfiniteScroll.js"
  "frontend/src/hooks/useDebounce.js"

  # Frontend – Utils & Styles
  "frontend/src/utils/constants.js"
  "frontend/src/utils/formatters.js"
  "frontend/src/utils/validators.js"
  "frontend/src/styles/globals.css"
  "frontend/src/styles/index.css"

  # Intégration tests & config
  "integration/tests/auth.test.js"
  "integration/tests/article-flow.test.js"
  "integration/config/cypress.config.js"

  # Docs (dossiers uniquement, pas de fichiers listés ici pour l'instant)
  "docs/api/rest-api.md"
  "docs/api/soap-api.md"
  "docs/architecture/system-overview.md"
  "docs/architecture/database-schema.md"
  "docs/deployment/local-setup.md"
  "docs/deployment/render-setup.md"
  "docs/deployment/vercel-setup.md"

  # Scripts utilitaires
  "scripts/build-all.sh"
  "scripts/generate-soap-client.sh"
  "scripts/cleanup.sh"
)

for path in "${files[@]}"; do
  dir="$(dirname "$path")"
  # Crée le dossier si nécessaire
  mkdir -p "$dir"
  # Crée le fichier s'il n'existe pas déjà
  if [[ ! -e "$path" ]]; then
    touch "$path"
  fi
done

echo "✅ Structure de projet vérifiée/créée avec succès (hors desktop-client)."
