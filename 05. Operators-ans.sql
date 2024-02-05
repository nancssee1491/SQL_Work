-- Assignments – Operators

-- 1. Create a Student_DB with the tables created from the datasets shared (students.csv files)
create database Student_DB;
use Student_DB;
select* from Student;

-- 2. Write a SQL query to display all the unique values in the "section" column of the "students" table.
select distinct Section from Student;

-- 3. Write a SQL query to display the top 5 highest marks from the "students" table.
select Science_Marks from Student order by Science_Marks desc limit 5;

-- 4. Write a SQL query to display the number of students in each class from the "students" table.
select Class, count(Name) as Number_of_Students 
from Student 
group by Class; 

-- 5. Write a SQL query to display the average marks of all in each section from the "students" table.
select Section, avg(Science_Marks) as Section_Average_Marks
from Student
group by Section;

-- 6. Write a SQL query to display the names and marks of all students in the "students" table in descending order of enrollment_no.
select Enrollment_NO, Name, Science_Marks from Student order by Enrollment_NO desc;

-- 7. Write a SQL query to display the names of all students who scored in the "science_marks" and get a marks greater than 60.
select Name from Student where Science_Marks > 60;
