create database library_p;

drop table if exists branch;
create table branch(
branch_id varchar(10) primary key,
manager_id varchar(10),
branch_address varchar(45),
contact_no varchar(10));

drop table if exists employees;
create table employees(
emp_id varchar(10)primary key,
emp_name varchar(25),
position varchar(20),
salary int,
branch_id varchar(20)
);
drop table if exists books;
create table books(
	isbn varchar(25) primary key,
 	book_title varchar(25),
	category varchar(20),
	rental_price float,
	status varchar(10),
	author varchar(30),
	publisher varchar(30)
);

drop table if exists members;
create table members(
	member_id varchar(20) primary key,
	member_name varchar(30),
	member_address varchar(30),
	reg_date date
);

drop table if exists issued_status;
create table issued_status
(
    issued_id varchar(10) primary key,
    issued_member_id varchar(30),
    issued_book_name varchar(80),
    issued_date date,
    issued_book_isbn varchar(50),
    issued_emp_id varchar(10),
    foreign key (issued_member_id) references members(member_id),
    foreign key (issued_emp_id) references employees(emp_id),
    foreign key (issued_book_isbn) references books(isbn)
);


drop table if exists return_status;
create table return_status
(
    return_id varchar(10) primary key,
    issued_id varchar(30),
    return_book_name varchar(80),
    return_date date,
    return_book_isbn varchar(50),
    foreign key (return_book_isbn) references books(isbn)
);


-- creating foreign key for employees table
alter table employees
add constraint fk_branch
foreign key(branch_id)
references branch(branch_id);

-- creating foreign key for return_status table
alter table return_status
add constraint fk_issued_status
foreign key(issued_id)
references issue_status(issued_id);


-- Q1  Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books (isbn,book_title,category,rental_price,status,author,publisher)
values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
select*from books where isbn='978-1-60129-456-2';

-- Q2  Update an Existing Member's Address
update members
set member_address='Kaveri nagar 4th cross'
where member_id='C101';


-- Q3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
delete from issued_status
where issued_id='IS121';

-- Q4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
select*from employees where emp_id='E101';

-- Q5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
select issued_emp_id,count(*) from issued_status group by 1 having count(*)>1;

-- Q6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
-- (CTAS) create table as task
create table book_counts as(
select
	b.isbn,
    b.book_title,
    count(i.issued_id) as no_issued
from books b
join issued_status i
on b.isbn=i.issued_book_isbn
group by 1,2);

-- Q7. Retrieve All Books in a Specific Category
select*
from books
where category='classic';

-- Q 8: Find Total Rental Income by Category
select 
	b.isbn,
    sum(b.rental_price),
    count(*)
from books b
join issued_status i
on b.isbn=i.issued_book_isbn
group by 1;


-- Q9 List Members Who Registered in the Last 180 Days
select*from members
where reg_date>=curdate()-interval 180 day;

-- Q10 List Employees with Their Branch Manager's Name and their branch details
select
	e.branch_id,
    e.emp_id,
    e.position,
    e.salary,
    b.*,
    e1.emp_id as manager
from employees e
join branch b
using(branch_id) 
join employees e1
on e1.emp_id = b.manager_id;

-- Q11. Create a Table of Books with Rental Price Above a Certain Threshold
create table expensive_book as 
select*from books
where rental_price>=7.0;

select*from expensive_book;

-- Q12: Retrieve the List of Books Not Yet Returned
select
	i.issued_book_name,
    i.issued_book_isbn
from issued_status i
left join return_status r
using(issued_id)
where r.return_id is null;