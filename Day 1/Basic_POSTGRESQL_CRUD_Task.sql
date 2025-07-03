-- Step 1: Create Students Table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    enrollment_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- Step 2: Create Courses Table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL,
    student_id INTEGER REFERENCES students(student_id)
);

-- Step 3: Insert One Student
INSERT INTO students (first_name, last_name, email, enrollment_date)
VALUES ('Aryan', 'Shah', 'aryan.shah@university.com', '2024-08-15');

-- Step 4: Insert Multiple Students
INSERT INTO students (first_name, last_name, email, enrollment_date, is_active) VALUES
('Meera', 'Patel', 'meera.patel@university.com', '2023-07-01', TRUE),
('Nikhil', 'Desai', 'nikhil.desai@university.com', '2022-06-10', FALSE),
('Tanya', 'Verma', 'tanya.verma@university.com', '2024-01-20', TRUE),
('Karan', 'Rao', 'karan.rao@university.com', '2021-09-05', TRUE);

-- Step 5: Insert Courses
INSERT INTO courses (course_name, credits, student_id) VALUES
('Mathematics', 4, 1),
('Physics', 3, 1),
('Computer Science', 4, 2),
('Biology', 3, 3),
('Statistics', 2, 4),
('Economics', 3, 1);

-- Step 6: SELECT Queries
SELECT first_name FROM students;
SELECT first_name, last_name, email FROM students;
SELECT * FROM students;

-- Step 7: ORDER BY
SELECT * FROM students ORDER BY enrollment_date DESC;
SELECT * FROM students ORDER BY last_name ASC, first_name ASC;

-- Step 8: WHERE Clause
SELECT * FROM students WHERE is_active = TRUE;
SELECT * FROM students WHERE enrollment_date < '2023-01-01';
SELECT * FROM students WHERE first_name ILIKE '%an%';

-- Step 9: JOINs
SELECT s.first_name, s.last_name, c.course_name
FROM students s
JOIN courses c ON s.student_id = c.student_id;

SELECT s.first_name, c.course_name
FROM students s
LEFT JOIN courses c ON s.student_id = c.student_id;

-- Step 10: GROUP BY
SELECT s.student_id, s.first_name, COUNT(c.course_id) AS total_courses
FROM students s
JOIN courses c ON s.student_id = c.student_id
GROUP BY s.student_id;

-- Step 11: GROUP BY with HAVING
SELECT s.student_id, COUNT(c.course_id) AS course_count
FROM students s
JOIN courses c ON s.student_id = c.student_id
GROUP BY s.student_id
HAVING COUNT(c.course_id) >= 2;

-- Step 12: Subqueries

-- Subquery using IN
SELECT * FROM courses
WHERE student_id IN (
    SELECT student_id FROM students WHERE is_active = TRUE
);

-- Subquery using EXISTS
SELECT first_name, last_name FROM students
WHERE EXISTS (
    SELECT 1 FROM courses WHERE courses.student_id = students.student_id
);

-- Step 13: UPDATE
UPDATE students
SET email = 'karan.rao99@university.com'
WHERE student_id = 5;

-- Step 14: DELETE
DELETE FROM students WHERE student_id = 3;

-- Step 15: ALTER TABLE - Add a new column
ALTER TABLE students ADD COLUMN graduation_year INT;

-- Step 16: ALTER TABLE - Rename column
ALTER TABLE students RENAME COLUMN email TO email_address;
ALTER TABLE students RENAME COLUMN email_address TO email;

-- Step 17: ALTER TABLE - Rename table
ALTER TABLE students RENAME TO learners;
ALTER TABLE learners RENAME TO students;

-- Step 18: DROP TABLE if exists
DROP TABLE IF EXISTS temp_table;
