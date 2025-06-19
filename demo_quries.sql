-- Set the current user for audit logging
SET @current_user_id = 1;

-- Create a new user
CALL add_user('Alice Sharma', 'alice@example.com', 'alice123');

-- Fetch user_id (simulate or dynamically query)
-- Assuming it's the last inserted
SET @alice_user_id = (SELECT MAX(user_id) FROM resume_users WHERE email = 'alice@example.com');

-- Create a new resume for Alice
CALL create_resume(@alice_user_id, 1, 'Alice Resume 2025');

-- Fetch resume_id
SET @alice_resume_id = (SELECT MAX(resume_id) FROM resume_resumes WHERE user_id = @alice_user_id);

-- Add education section data
CALL add_section_data(@alice_resume_id, 1, 'B.Sc in IT from DEF University', 'v1', 'en');

-- Add experience section data
CALL add_section_data(@alice_resume_id, 2, 'Intern at XYZ Pvt Ltd', 'v1', 'en');

-- Fetch section_data_id for education
SET @edu_section_data_id = (
    SELECT section_data_id
    FROM resume_sections_data
    WHERE resume_id = @alice_resume_id AND section_id = 1 AND version = 'v1'
    ORDER BY section_data_id DESC
    LIMIT 1
);

-- Tag the education section with tag name 'IT'
CALL tag_section_by_name(@edu_section_data_id, 'IT');

-- Fetch section_data_id for experience
SET @exp_section_data_id = (
    SELECT section_data_id
    FROM resume_sections_data
    WHERE resume_id = @alice_resume_id AND section_id = 2 AND version = 'v1'
    ORDER BY section_data_id DESC
    LIMIT 1
);

-- Soft delete the experience section
CALL soft_delete_section_data(@exp_section_data_id);

-- Restore the deleted section
CALL restore_section_data(@exp_section_data_id);

-- View audit log
SELECT * FROM resume_audit_log;

-- View export-ready resume
SELECT * FROM view_resume_export;
