-- Assignment - SQL Commands --

-- 1. Create a table called "students" with the following columns: "id" (integer, primary key), "name" (text), "age" (integer), "gender" (text), and "major" (text).
create database SQL_Commands;
use SQL_Commands;
create table students(id int primary key, name text(100), age int, gender text(50), major text(100));

-- 2. Insert a new row into the "students" table with the following values: id=1, name='John Smith', age=22, gender='Male', major='Computer Science'.
insert into students values(1, 'John Smith', 22, 'Male', 'Computer Science');

-- 3. Write a SQL query to retrieve the names of all students in the "students" table.
select name from students;

-- 4. Write a SQL query to retrieve the names and ages of all female students in the "students" table.
select name, age from students where gender = 'female';

-- 5. Write a SQL query to update the age of the student with id=1 to 23.
update students id set age=23 where id=1;

-- 6. Create a new table called "courses" with the following columns: "id" (integer, primary key), "name" (text), and "description" (text).
create table courses(id int primary key, name text(100), description text(100));

-- DATABASE CREATION: -
-- 1. Create a database ‘classroom’
create database classroom;
use classroom;

-- 2. Create a table named ‘science_class’ with the following properties:
-- a. columns(enrollment_no int, name varchar, science_marks int)
create table science_class(enrollment_no int, name varchar(100), science_marks int);

-- INSERTING & IMPORTING: -
-- 1. Insert the following data into science_class using the insert into command:
-- 1	popeye	33
-- 2	olive	54
-- 3	brutus	98
insert into science_class values(1, 'popeye', 33);
insert into science_class values(2, 'olive', 54);
insert into science_class values(3, 'brutus', 98);

-- 2. Import data from CSV file ‘student.csv’ attached in resources to science_class to insert data of the next 8 students
select* from science_class;

-- SELECT & WHERE: -
-- 1. Retrieve all data from the table ‘Science_Class’
select* from science_class;

-- 2. Retrieve the name of students who have scored more than 60 marks
select name from science_class where science_marks > 60;

-- 3. Retrieve all data of students who have scored more than 35 but less than 60 marks
select* from science_class where science_marks > 35 and science_marks < 60;

-- 4. Retrieve all other students i.e., who have scored less than or equal to 35 or more than or equal to 60.
select* from science_class where science_marks <= 35 or science_marks >= 60;

-- UPDATING TABLES: -
-- 1. Update the marks of popeye to 45
update science_class set science_marks=45 where name='popeye';

-- 2. Delete the row containing details of the student named ‘robb’
delete from science_class where name='robb';

-- 3. Rename column ‘name’ to ‘student_name’
alter table science_class rename column name to student_name;
