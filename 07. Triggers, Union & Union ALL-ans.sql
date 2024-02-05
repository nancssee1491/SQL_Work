-- Assignments – Triggers

-- 1. Write a SQL query that creates a trigger on a table.
DELIMITER $$
CREATE TRIGGER Trigger_Name
{BEFORE|AFTER} {INSERT|UPDATE|DELETE} ON Table_Name
FOR EACH ROW
BEGIN
-- Trigger Command Here --
END $$
DELIMITER ;

-- 2. Write a SQL query that uses a trigger to update data in a table.
DELIMITER $$
CREATE TRIGGER After_Insert_Trigger
AFTER INSERT ON Table1
FOR EACH ROW
BEGIN
	update Table2 set Column_Table2 = Updated_Value_Table2
    where Column_Table1 = new.Column_Table1;
END $$
DELIMITER ;
    
-- 3. Give an example of a scenario where a trigger would be useful in SQL, and explain how it can be implemented in a query.
/* 
Scenario:
Suppose want to update customer payment status automatically from 'Unpaid' to 'Paid' in 
Payment_Status column of Payment table, whenever fund received and recorded in Fund table, 
matching by customer IDs. 
*/
DELIMITER $$
CREATE TRIGGER Update_Payment_Status
AFTER INSERT ON Fund
FOR EACH ROW
BEGIN
	update Payment set Payment_Status = 'Paid'
    where customer_ID = new.customer_ID;
END $$
DELIMITER ;
	
-- 4. Explain the difference between the AFTER and INSTEAD OF trigger operators in SQL.
/*
AFTER Trigger: 
1) Executed automatically after the triggering event (INSERT, UPDATE, DELETE) has happened in a table.
2) Often being used to update data automatically when data in another table is being modified. 
*/
DELIMITER $$
CREATE TRIGGER After_Update_Data_Trigger
AFTER UPDATE ON Table_Name
FOR EACH ROW
BEGIN
-- The Trigger Command --
END $$
DELIMITER ;

/*
INSTEAD OF Trigger:
1) To override or replace defined default trigger action.
2) Provide customisation and flexibility on how database should react to the triggering event.
*/
DELIMITER $$
CREATE TRIGGER Instead_Of_After_Trigger
INSTEAD OF UPDATE ON Table_Name
FOR EACH ROW
BEGIN
-- Custom command to handle the deafult AFTER UPDATE Trigger --
END $$
DELIMITER ;

-- 5. What is the purpose of the INSTEAD OF DELETE trigger operator in SQL?
/*
To replace the default delete operation. Customise specifically how data should be handled when
delete action is triggered. */
