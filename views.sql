CREATE OR REPLACE VIEW view_resume_export AS
SELECT
  r.resume_id,
  r.title AS resume_title,
  u.user_id,
  u.username AS user_name,
  u.email,
  rs.section_name,
  rsd.content,
  rsd.version,
  rsd.language,
  GROUP_CONCAT(DISTINCT t.tag_name ORDER BY t.tag_name SEPARATOR ', ') AS tags,
  GROUP_CONCAT(DISTINCT uc.username ORDER BY uc.username SEPARATOR ', ') AS collaborators
FROM
  resume_resumes r
JOIN resume_users u ON r.user_id = u.user_id
JOIN resume_sections_data rsd ON rsd.resume_id = r.resume_id AND rsd.is_deleted = FALSE
JOIN resume_sections rs ON rs.section_id = rsd.section_id
LEFT JOIN resume_section_tags st ON st.section_data_id = rsd.section_data_id
LEFT JOIN resume_tags t ON t.tag_id = st.tag_id
LEFT JOIN resume_collaborators rc ON rc.resume_id = r.resume_id
LEFT JOIN resume_users uc ON uc.user_id = rc.collaborator_user_id
GROUP BY
  r.resume_id,
  r.title,
  u.user_id,
  u.username,
  u.email,
  rs.section_name,
  rsd.section_data_id,
  rsd.content,
  rsd.version,
  rsd.language;
