-- PROCEDURE: Add a New User
DELIMITER //
CREATE PROCEDURE add_user (
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_password_hash VARCHAR(255)
)
BEGIN
    INSERT INTO resume_users (username, email, password_hash)
    VALUES (p_username, p_email, p_password_hash);
END;
//
DELIMITER ;

-- PROCEDURE: Create a New Resume
DELIMITER //
CREATE PROCEDURE create_resume (
    IN p_user_id INT,
    IN p_template_id INT,
    IN p_title VARCHAR(255)
)
BEGIN
    INSERT INTO resume_resumes (user_id, template_id, title)
    VALUES (p_user_id, p_template_id, p_title);
END;
//
DELIMITER ;

-- PROCEDURE: Add Resume Section Data
DELIMITER //
CREATE PROCEDURE add_section_data (
    IN p_resume_id INT,
    IN p_section_id INT,
    IN p_content TEXT,
    IN p_version VARCHAR(20),
    IN p_language VARCHAR(20)
)
BEGIN
    INSERT INTO resume_sections_data (resume_id, section_id, content, version, language)
    VALUES (p_resume_id, p_section_id, p_content, p_version, p_language);
END;
//
DELIMITER ;

-- PROCEDURE: Add a Tag to a Section
DELIMITER //
CREATE PROCEDURE add_section_tag (
    IN p_section_data_id INT,
    IN p_tag_id INT
)
BEGIN
    INSERT INTO resume_section_tags (section_data_id, tag_id)
    VALUES (p_section_data_id, p_tag_id);
END;
//
DELIMITER ;

-- PROCEDURE: Soft Delete Section Data
DELIMITER //
CREATE PROCEDURE soft_delete_section_data (
    IN p_section_data_id INT
)
BEGIN
    UPDATE resume_sections_data
    SET is_deleted = TRUE
    WHERE section_data_id = p_section_data_id;
END;
//
DELIMITER ;

-- PROCEDURE: Restore Section Data
DELIMITER //
CREATE PROCEDURE restore_section_data (
    IN p_section_data_id INT
)
BEGIN
    UPDATE resume_sections_data
    SET is_deleted = FALSE
    WHERE section_data_id = p_section_data_id;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE tag_section_by_name(
  IN p_section_data_id INT,
  IN p_tag_name VARCHAR(50)
)
BEGIN
  DECLARE v_tag_id INT;
  
  -- Insert tag if it doesn't exist
  INSERT IGNORE INTO resume_tags (tag_name) VALUES (p_tag_name);

  -- Get tag ID
  SELECT tag_id INTO v_tag_id FROM resume_tags WHERE tag_name = p_tag_name;

  -- Tag the section
  INSERT INTO resume_section_tags (section_data_id, tag_id)
  VALUES (p_section_data_id, v_tag_id);
END;
//
DELIMITER ;
