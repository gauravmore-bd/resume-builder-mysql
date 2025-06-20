<<<<<<< HEAD
# 🧾 Online Resume Builder (MySQL Only)

This is a **feature-rich, normalized MySQL database** schema designed for an Online Resume Builder system. It supports user accounts, resume templates, multi-section content, tags, versioning, collaboration, audit logging, soft deletes, and a unified export view.

---

## 📁 Project Structure

| File Name              | Purpose                                                      |
|------------------------|--------------------------------------------------------------|
| `schema.sql`           | Defines all database tables and relationships                |
| `sample_data.sql`      | Inserts sample data (users, resumes, tags, collaborators)    |
| `procedures.sql`       | Contains stored procedures for core operations               |
| `triggers.sql`         | Defines triggers for audit logging                           |
| `views.sql`            | Creates export-ready read-only views                         |
| `demo_queries.sql`     | End-to-end demo/test flow with real data and logs            |

---

## 🛠️ Setup Instructions

Run these SQL files **in the given order** to initialize the system:

### 1. Create the Database and Tables
```sql
SOURCE schema.sql;
```
### 2. Insert Sample Data
```sql
SOURCE sample_data.sql;
```

### 3. Define Stored Procedures
```sql
SOURCE procedures.sql;
```

### 4. Define Triggers for Audit Logging
```sql
SOURCE triggers.sql;
```

### 5. Create Resume Export View
```sql
SOURCE views.sql;
```

### 6. Run the Demo & Test Queries
```sql
SOURCE demo_queries.sql;
```

### ✅ Features
👤 User Management
📄 Resume Templates & Titles
📑 Multi-section Resume Content (Education, Experience, etc.)
🌐 Multi-language Support
🏷️ Tagging System (Skills, Roles, Fields)
📜 Versioning per Section
🗂️ Soft Delete & Restore Functionality
👥 Resume Collaboration (Multiple Users)
🧾 Audit Logging via Triggers
📤 Export-ready Resume View (for PDF or Frontend Rendering)

### 🔍 Export Resume View
Use this view to fetch the full, formatted resume data for export or rendering:

```sql
SELECT * FROM view_resume_export;
```

This includes:
Resume ID, title
Owner details (user)
Collaborators
Each section’s content, version, language
Associated tags (like "Python", "Manager")


### 🧪 Audit Log
All inserts, updates, and soft deletes to resume content are logged in:

```sql
SELECT * FROM resume_audit_log;
```

Each record includes:
-user_id (set via @current_user_id)
-Action type: 'INSERT', 'UPDATE', 'DELETE'
-Table and record affected
-Timestamp and description

## Before running any insert/update/delete operation, set:
```sql
SET @current_user_id = 1; -- or any valid user_id
```

### 📌 Stored Procedures Included
-add_user(username, email, password_hash)
-create_resume(user_id, template_id, title)
-add_section_data(resume_id, section_id, content, version, language)
-soft_delete_section_data(section_data_id)
-restore_section_data(section_data_id)
-add_section_tag(section_data_id, tag_id)
-tag_section_by_name(section_data_id, tag_name) ✅ (automatically creates tags)

## 🧩 Demo Queries
-Run demo_queries.sql to simulate:
-Creating a new user and resume
-Adding multiple sections
-Adding tags to a section
-Soft deleting and restoring a section
-Fetching audit logs
-Viewing export-ready data
=======
# resume-builder-mysql
MySQL-only database for an Online Resume Builder system
>>>>>>> 3117d6f463e8692c336d3b602a85b98f3cb8800b
