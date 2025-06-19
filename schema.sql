-- Drop existing database if exists
DROP DATABASE IF EXISTS resume_builder;
CREATE DATABASE resume_builder;
USE resume_builder;

-- 1. USERS TABLE
CREATE TABLE resume_users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. RESUME TEMPLATES TABLE
CREATE TABLE resume_templates (
    template_id INT AUTO_INCREMENT PRIMARY KEY,
    template_name VARCHAR(100) NOT NULL,
    layout JSON
    -- If using MySQL < 5.7, change to: layout TEXT
);

-- 3. RESUMES TABLE
CREATE TABLE resume_resumes (
    resume_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    template_id INT,
    title VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES resume_users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (template_id) REFERENCES resume_templates(template_id) ON DELETE SET NULL
);

-- 4. RESUME COLLABORATORS
CREATE TABLE resume_collaborators (
    resume_id INT,
    collaborator_user_id INT,
    PRIMARY KEY (resume_id, collaborator_user_id),
    FOREIGN KEY (resume_id) REFERENCES resume_resumes(resume_id) ON DELETE CASCADE,
    FOREIGN KEY (collaborator_user_id) REFERENCES resume_users(user_id) ON DELETE CASCADE
);

-- 5. RESUME SECTIONS
CREATE TABLE resume_sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    section_name VARCHAR(100) NOT NULL UNIQUE
);

-- 6. SECTION DATA (User Content)
CREATE TABLE resume_sections_data (
    section_data_id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT NOT NULL,
    section_id INT NOT NULL,
    content TEXT,
    version VARCHAR(20),       -- Increased size for flexibility
    language VARCHAR(20),      -- Increased size for flexibility
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (resume_id) REFERENCES resume_resumes(resume_id) ON DELETE CASCADE,
    FOREIGN KEY (section_id) REFERENCES resume_sections(section_id) ON DELETE CASCADE
);

-- 7. RESUME VERSIONS
CREATE TABLE resume_versions (
    version_id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT NOT NULL,
    version_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resume_id) REFERENCES resume_resumes(resume_id) ON DELETE CASCADE,
    UNIQUE (resume_id, version_name)  -- Ensure unique version per resume
);

-- 8. TAGS TABLE
CREATE TABLE resume_tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(50) UNIQUE NOT NULL
);

-- 9. SECTION TAGS (Many-to-Many
CREATE TABLE resume_section_tags (
    section_data_id INT,
    tag_id INT,
    PRIMARY KEY (section_data_id, tag_id),
    FOREIGN KEY (section_data_id) REFERENCES resume_sections_data(section_data_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES resume_tags(tag_id) ON DELETE CASCADE
);

-- 10. AUDIT LOG TABLE
CREATE TABLE resume_audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL, -- Made nullable for ON DELETE SET NULL to work
    action ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    record_id INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES resume_users(user_id) ON DELETE SET NULL
);
