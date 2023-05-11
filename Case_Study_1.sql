create database CaseStudies;
use CaseStudies;

create table oscar_nominees (
year year,
category varchar(50),
nominee varchar(30),
movie varchar(30),
winner bool,
id int not null,
primary key(id)
);


# Write a query to display all the records in the table tutorial.oscar_nominees
SELECT * FROM oscar_nominees;

# Write a query to find the distinct values in the ‘year’ column
select distinct year from oscar_nominees;

# Write a query to filter the records from year 1999 to year 2006
select * from oscar_nominees where year between 1999 and 2006;

# Write a query to filter the records for either year 1991 or 1998
select * from oscar_nominees where year=1991 or year=1998;

# Write a query to return the winner movie name for the year of 1997
select movie from oscar_nominees where year=1997 and winner='true';

# Write a query to return the winner in the ‘actor in a leading role’ and ‘actress in a leading role’ category for the year of 1994,1980, and 2008
select * from oscar_nominees where (category='actor in a leading role' or category='actress in a leading role') and year IN(1994,1980,2008) and winner='true';

# Write a query to return the name of the movie starting from letter ‘a’
select movie from oscar_nominees where movie like 'a%';

# Write a query to return the name of movies containing the word ‘the’
select movie from oscar_nominees where movie like '%the%';

# Write a query to return all the records where the nominee name starts with “c” and ends with “r”
select * from oscar_nominees where nominee like 'c%r';

# Write a query to return all the records where the movie was released in 2005 and movie name does not start with ‘a’ and ‘c’ and nominee was a winner
select * from oscar_nominees where year=2005 and (movie not like 'a%' and movie not like 'c%') and winner='true';

# Write a query to return the name of nominees who got more nominations than ‘Akim Tamiroff’. Solve this using CTE
with cte as (select nominee, count(*) as num_nominations from oscar_nominees group by 1)
select nominee from cte where num_nominations>(select num_nominations from cte where nominee='Akim Tamiroff');

# Write a query to find the nominee name with the second highest number of oscar wins. Solve using subquery.
with oscar_wins as 
(select nominee, count(*) as num_oscar_wins from oscar_nominees where winner='True' group by 1 order by 2 desc) 
select nominee, num_oscar_wins
from oscar_wins 
where num_oscar_wins = (select max(num_oscar_wins) from oscar_wins where num_oscar_wins<(select max(num_oscar_wins) from oscar_wins));

# Write a query to create three columns per nominee
/* 1. Number of wins
2. Number of loss
3. Total nomination  */
select nominee, 
sum(case when winner='true' then 1 else 0 end) as num_wins,
sum(case when winner='false' then 1 else 0 end) as num_loss,
count(*) as total_nominations
from oscar_nominees 
group by 1
order by 4 desc;

# Write a query to create two columns
/* ● Win_rate: Number of wins/total wins
● Loss_rate: Number of loss/total wins   */
select movie, 
100*sum(case when winner='true' then 1 else 0 end)/count(*) as win_rate,
100*sum(case when winner='false' then 1 else 0 end)/count(*) as loss_rate
from oscar_nominees
group by 1;

# Write a query to return all the records of the nominees who have lost but won at least once
select * 
from oscar_nominees 
where nominee in(select distinct nominee from oscar_nominees where winner= 'true') and winner = 'false';

# Write a query to find the nominees who are nominated for both ‘actor in a leading role’ and ‘actor in supporting role’
select distinct nominee from oscar_nominees 
where nominee in(select nominee from oscar_nominees where category='actor in a leading role') 
and category='actor in a supporting role';

# Write a query to find the movie which won more than average number of wins per winning movie
with cte as (select movie, count(*) as num_wins from oscar_nominees where winner='true' group by 1)
select movie from cte where num_wins>(select avg(num_wins) from cte);

# Write a query to return the year which have more winners than year 1970
with cte as (select year, count(*) as num_wins from oscar_nominees where winner='true' group by 1)
select year from cte where num_wins > (select num_wins from cte where year=1970);

# Write a query to return all the movies which have won oscars both in the actor and actress category
select distinct movie
from oscar_nominees 
where (winner='true' and category like '%actor%')
and movie in(select movie from oscar_nominees where category like '%actress%' and winner='true');

# Write a query to return the movie name which did not win a single oscar
with cte as
(select movie, 
sum(case when winner='true' then 1 else 0 end) as num_wins,
sum(case when winner='false' then 1 else 0 end) as num_loss
from oscar_nominees
group by 1)
select distinct movie from cte where num_wins=0;

# METHOD 2 for above query
select distinct movie 
from oscar_nominees 
where winner='false' and movie not in(select distinct movie from oscar_nominees where winner='true');






SELF Prectice
Q1.
Find the details of each customer regardless of whether the customer made an order. Output the customer's first name, last name, 
and the city along with the order details.You may have duplicate rows in your results due to a customer ordering several of the same items. 
Sort records based on the customer's first name and the order details in ascending order.

Ans.
    SELECT first_name,last_name, city, order_details
    FROM customers 
    lEFT JOIN orders 
    ON customers.id = orders.cust_id
    ORDER BY first_name, order_details;

Q2.Meta/Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees. 
The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack. 
Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location. 
Luckily the user IDs of employees completing the surveys were stored.
Based on the above, find the average popularity of the Hack per office location.
Output the location along with the average popularity.

Ans.SELECT location, AVG(popularity)
FROM facebook_employees AS location
JOIN facebook_hack_survey AS popularity
ON location.id = popularity.employee_id
GROUP BY location;
OR 

SELECT location, AVG(popularity)
FROM facebook_employees a
JOIN facebook_hack_survey b
ON a.id = b.employee_id
GROUP BY location;

Q3.
Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order.
Ans.
SELECT first_name, order_date, order_details, total_order_cost
FROM customers
JOIN orders order_details on customers.id = order_details.cust_id
WHERE customers.first_name IN ('Jill','Eva')
ORDER BY customers.id ASC;

SELECT first_name, order_date, order_details, total_order_cost
FROM customers
JOIN orders on customers.id = orders.cust_id
where first_name IN ('Jill', 'Eva')
ORDER BY cust_id;

Q4.
Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. 
If customer had more than one order on a certain day, sum the order costs on daily basis. 
Output customer's first name, total cost of their items, and the date.
For simplicity, you can assume that every first name in the dataset is unique.

select customers.id,order_date,first_name,sum(total_order_cost) as total_cost 
FROM
customers right join orders
on customers.id = orders.cust_id
where order_date between '2019-02-01' and '2019-05-01'
group by customers.id , order_date
order by total_cost desc
limit 1;

https://platform.stratascratch.com/data-projects/insights-failed-orders?tabname=solution
https://www.hackerrank.com/challenges/african-cities/submissions/code/312496502
https://www.geeksforgeeks.org/joining-three-tables-sql/







