use mavenmovies; -- This is for selecting the mavenmovies database

/*
Q1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 

SELECT 
	first_name,
    last_name,
    email,
    store_id
FROM staff;

/*
Q2.	We will need separate counts of inventory items held at each of your two stores. 
*/ 

SELECT 
	store_id,
    COUNT(inventory_id) AS Inventory_Count
FROM 
	inventory
GROUP BY
	store_id
ORDER BY
	store_id;

/*
Q3.	We will need a count of active customers for each of your stores. Separately, please. 
*/

SELECT 
	store_id, 
    COUNT(customer_id) AS Active_Customer_Count
FROM
	customer
WHERE
	active = 1
GROUP BY
	store_id
ORDER BY
	store_id;


/*
Q4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/

SELECT 
	COUNT(email) AS Number_Of_Email_Addresses
FROM
	customer;

/*
Q5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/

SELECT 
	store_id,
    COUNT(DISTINCT film_id) AS Unique_Films 
FROM
	inventory
GROUP BY
	store_id
ORDER BY
	store_id;

SELECT 
	COUNT(DISTINCT category_id) AS Unique_Categories
FROM 
	category;

/*
Q6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/

SELECT 
	MIN(replacement_cost) AS "Least expensive film to replace",
    MAX(replacement_cost) AS "Least expensive film to replace",
    AVG(replacement_cost) AS "Least expensive film to replace"
FROM
	film;

/*
Q7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/

SELECT 
	AVG(amount) AS "Average Payment processed",
    MAX(amount) AS "Maximum Payment processed"    
FROM payment;

/*
Q8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/

SELECT 
	customer_id,
    COUNT(rental_id) AS "Rental_Count"
FROM rental
GROUP BY customer_id
ORDER BY Rental_Count DESC;


/*
Q9.	I would like to know which store each customer goes to, and whether they are active or not.
Could you pull a list of first and last names of all customers, and label them as either 
‘store 1 active’, ‘store 1 inactive’, ‘store 2 active’, or ‘store 2 inactive’?”
*/

SELECT 
	first_name,
    last_name,
	CASE 
		 WHEN store_id=1 AND active=1 THEN "store 1 active"
         WHEN store_id=1 AND active=0 THEN "store 1 inactive"
         WHEN store_id=2 AND active=1 THEN "store 2 active"
         WHEN store_id=2 AND active=0 THEN "store 2 inactive"
		 ELSE "It is not captured"
	END AS "Store_and_Status"
FROM customer;

/*
Q10. “I’m curious how many inactive customers we have at each store. 
Could you please create a table to count the number of customers broken down 
by store_id (in rows), and active status (in columns)?”

*/

SELECT 
	store_id,
    COUNT(CASE WHEN active=1 THEN customer_id ELSE NULL END) AS "Active_Customer_Count",
    COUNT(CASE WHEN active=0 THEN customer_id ELSE NULL END) AS "InActive_Customer_Count"
FROM customer
GROUP BY store_id


