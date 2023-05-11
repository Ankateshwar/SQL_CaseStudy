show databases;
-- show tables;

-- select employee from persons1;

-- CREATE DATABASE recipes_database; 
use recipes_database;
CREATE TABLE recipes(
recipe_id INT NOT NULL PRIMARY KEY,
recipe_name VARCHAR(30) NOT NULL UNIQUE
 );
INSERT INTO recipes (recipe_id, recipe_name)
VALUES
(1,"Pav Bhaji"),
(2,"Monchow Soup"),
(3,"Grilled Sandwich"),
(4,"Puri Sabji");
show databases;
use persons1;
use recipes_database;
select * from table_3;
select * from recipes;
show databases;
use all_test;
INSERT INTO table_3(emp_id,emp_name,emp_code,emp_salary)
values (103,'ramesh',2024,30000);
INSERT INTO table_3(emp_id,emp_name,emp_code,emp_salary)
values (101,'rahul',2020,40000);
INSERT INTO table_3(emp_salary)
values (25000);
UPDATE table_3 SET emp_salary= 25000 WHERE emp_id=101;
update recipes set recipe_name="Pav bhaji" where recipe_id=1;