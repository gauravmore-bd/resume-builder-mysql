-- 1. USERS
INSERT INTO resume_users (user_id, username, email, password_hash) VALUES
  (1, 'john_doe', 'john@example.com', 'hash1'),
  (2, 'jane_smith', 'jane@example.com', 'hash2');

-- 2. TEMPLATES
INSERT INTO resume_templates (template_id, template_name, layout) VALUES
  (1, 'Classic', NULL),
  (2, 'Modern', NULL);

-- 3. RESUMES
INSERT INTO resume_resumes (resume_id, user_id, template_id, title) VALUES
  (1, 1, 1, 'John Doe Resume'),
  (2, 2, 2, 'Jane Smith Professional Resume');

-- 4. VERSIONS
INSERT INTO resume_versions (version_id, resume_id, version_name) VALUES
  (1, 1, 'v1'),
  (2, 2, 'v1');

-- 5. RESUME SECTIONS
INSERT INTO resume_sections (section_id, section_name) VALUES
  (1, 'Education'),
  (2, 'Experience'),
  (3, 'Skills');

-- 6. RESUME SECTIONS DATA
INSERT INTO resume_sections_data (section_data_id, resume_id, section_id, content, version, language, is_deleted) VALUES
  (1, 1, 1, 'B.Sc in Computer Science from XYZ University', 'v1', 'en', FALSE),
  (2, 1, 2, 'Software Engineer at ABC Corp', 'v1', 'en', FALSE),
  (3, 1, 3, 'Python, SQL, Java', 'v1', 'en', FALSE),
  (4, 2, 1, 'MBA in Marketing from DEF Institute', 'v1', 'en', FALSE),
  (5, 2, 2, 'Marketing Manager at GHI Ltd.', 'v1', 'en', FALSE),
  (6, 2, 3, 'SEO, SEM, Content Marketing', 'v1', 'en', FALSE);


-- 7. TAGS
INSERT INTO resume_tags (tag_id, tag_name) VALUES
  (1, 'Computer Science'),
  (2, 'Marketing'),
  (3, 'Developer'),
  (4, 'Manager');


-- 8. SECTION TAGS
INSERT INTO resume_section_tags (section_data_id, tag_id) VALUES
  (1, 1),
  (2, 3),
  (4, 2),
  (5, 4);


-- 9. COLLABORATORS
INSERT INTO resume_collaborators (resume_id, collaborator_user_id) VALUES
  (1, 2),
  (2, 1);
