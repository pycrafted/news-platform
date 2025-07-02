-- Migration V2 : Ajout de données d'exemple pour le développement
INSERT INTO users (id, username, email, password_hash, role, is_active) VALUES
  ('00000000-0000-0000-0000-000000000003', 'charlie', 'charlie@example.com', '$2a$10$hash3', 'USER', true);

INSERT INTO categories (id, name, slug, description) VALUES
  ('10000000-0000-0000-0000-000000000003', 'Culture', 'culture', 'Catégorie pour la culture');

INSERT INTO articles (id, title, slug, content, author_id, category_id, status) VALUES
  ('20000000-0000-0000-0000-000000000003', 'Troisième article', 'troisieme-article', 'Contenu de l\'article 3', '00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000003', 'PUBLISHED'); 