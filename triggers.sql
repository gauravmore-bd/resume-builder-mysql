-- Trigger: Log INSERT actions
DELIMITER //
CREATE TRIGGER trg_log_insert
AFTER INSERT ON resume_sections_data
FOR EACH ROW
BEGIN
  INSERT INTO resume_audit_log (user_id, action, table_name, record_id, description)
  VALUES (
    @current_user_id,
    'INSERT',
    'resume_sections_data',
    NEW.section_data_id,
    CONCAT('Inserted content: ', NEW.content)
  );
END;
//
DELIMITER ;

-- Trigger: Log UPDATE actions
DELIMITER //
CREATE TRIGGER trg_log_update
AFTER UPDATE ON resume_sections_data
FOR EACH ROW
BEGIN
  INSERT INTO resume_audit_log (user_id, action, table_name, record_id, description)
  VALUES (
    @current_user_id,
    'UPDATE',
    'resume_sections_data',
    NEW.section_data_id,
    CONCAT('Updated content from: ', OLD.content, ' to: ', NEW.content)
  );
END;
//
DELIMITER ;

-- Trigger: Log DELETE actions (soft delete)
DELIMITER //
CREATE TRIGGER trg_log_soft_delete
AFTER UPDATE ON resume_sections_data
FOR EACH ROW
BEGIN
  IF OLD.is_deleted = FALSE AND NEW.is_deleted = TRUE THEN
    INSERT INTO resume_audit_log (user_id, action, table_name, record_id, description)
    VALUES (
      @current_user_id,
      'DELETE',
      'resume_sections_data',
      NEW.section_data_id,
      'Soft deleted section data'
    );
  END IF;
END;
//
DELIMITER ;
