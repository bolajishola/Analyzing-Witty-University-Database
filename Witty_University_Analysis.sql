
USE WittyUniversity
--1. What is the distribution of students based on majors?
		
		SELECT s.major, COUNT(s.student_id) AS student_count
		FROM Students s
		LEFT JOIN Enrollments e
		ON s.student_id = e.student_id
		LEFT JOIN Courses c
		ON e.course_id = c.course_id
		GROUP BY s.major;

--2. How many students are enrolled in each major?
		
		SELECT c.department, COUNT(s.student_id) AS student_count
		FROM students s
		LEFT join Enrollments e
		ON s.student_id = e.student_id
		LEFT JOIN Courses c
		ON c.course_id = e.course_id
		GROUP BY c.department;

--3. What is the overall enrollment trend over the years?

		SELECT YEAR(enrollment_date) AS enrollment_year, COUNT(enrollment_id) AS enrollment_count
		FROM Enrollments
		GROUP BY YEAR(enrollment_date)
		ORDER BY enrollment_year;

--4. Which courses have the highest and lowest enrollments?
		
		SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
		FROM Courses c
		JOIN Enrollments e
		ON c.course_id = e.course_id
		GROUP BY c.course_name
		ORDER BY enrollment_count DESC; -- for highest enrollments

--5. How many credit hours do students typically take per semester?

		SELECT AVG(credit_hours) AS avg_credit_hours
		FROM Courses;

--6. What departments offer the most and least credit hours?

		SELECT department, SUM(credit_hours) AS total_credit_hours
		FROM Courses
		GROUP BY department
		ORDER BY total_credit_hours DESC; -- for most credit hours

--7. What is the age distribution of students in each major?

		SELECT major, AVG(DATEDIFF(YEAR, date_of_birth, GETDATE())) AS avg_age
		FROM students
		GROUP BY major;

--8. How does the credit hours offered by departments impact student enrollment?

		SELECT c.department, COUNT(e.student_id) AS enrollment_count
		FROM Courses c
		JOIN Enrollments e
		ON c.course_id = e.course_id
		GROUP BY c.department;

--9. What is the distribution of students across different age groups?

		SELECT
			CASE
				WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 18 AND 21 THEN '18-21'
				WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 22 AND 25 THEN '22-25'
				WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 26 AND 30 THEN '26-30'
				ELSE '30+'
			END AS age_group,
			COUNT(student_id) AS student_count
		FROM students
		GROUP BY
		CASE
			WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 18 AND 21 THEN '18-21'
			WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 22 AND 25 THEN '22-25'
			WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 26 AND 30 THEN '26-30'
			ELSE '30+'
		END;

--10. How has the enrollment pattern changed for specific majors over the last two years?
		
		SELECT
				major,
				YEAR(enrollment_date) AS enrollment_year,
				COUNT(enrollment_id) AS enrollment_count
		FROM	
			students
		JOIN Enrollments 
		ON students.student_id = Enrollments.student_id
		WHERE
			major IN ('Computer Science', 'Business Administration', 'Psychology') -- Include specific majors of interest
		AND enrollment_date BETWEEN DATEADD(YEAR, -2, GETDATE()) AND GETDATE() -- Last two years
		GROUP BY
			major, YEAR(enrollment_date)
		ORDER BY
			major, enrollment_year;

