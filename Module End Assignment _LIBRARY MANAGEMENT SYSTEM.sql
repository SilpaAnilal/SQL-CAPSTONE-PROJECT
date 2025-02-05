create database Library;
use library;

create table Branch(
Branch_no int primary key auto_increment,
Manager_Id int,
Branch_address varchar(200),
Contact_no varchar(15)
);
create table Employee(
Emp_Id  int primary key auto_increment,
Emp_name varchar(50), 
Position varchar(50),
Salary int(15),
Branch_no int,
foreign key (branch_no) references Branch(Branch_no)
);
create table Books(
ISBN int primary key,
Book_title varchar(200),
Category varchar(200),
Rental_Price decimal(10, 2),
Status varchar(3),  # 'yes' for available, 'no' for not available
Author varchar(100),
Publisher varchar(100)
);
create table Customer(
Customer_Id int primary key,
Customer_name varchar(100),
Customer_address varchar(300),
Reg_date date
);
create table IssueStatus(
Issue_Id int primary key,
Issued_cust int,
Issued_book_name varchar(200),
Issue_date date,
ISBN_book int,
FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY (ISBN_book) REFERENCES Books(ISBN)
);
create table ReturnStatus(
Return_Id int primary key,
Retun_cust int,
Return_book_name varchar(200),
Return_date date,
ISBN_book2 int,
foreign key (ISBN_book2) REFERENCES Books(ISBN)
);

insert into branch values
(default,101,'134,ABC Street,New York','9567123487'),
(default,102,'657,New Street,Oyster Bay','9988771122'),
(default,103,'401,Washington Square,New York','9852147632');
select * from branch;

insert into employee values
(1,'Alice','Manager','53000',1),
(2,'Charlie','Manager','51000',2),
(3,'Grace','Asst.Manager','48000',3),
(4,'Kevin','Manager','52000',3),
(5,'Ziya','Asst.Manager','47500',2),
(6,'Kelvin','Assistant','45000',3),
(7,'Rose','Assistant','46000',3),
(8,'Isac','Cashier','51000',3),
(9,'Evan','Asst.Manager','48000',1)
(10,'Peter','Cashier','50000',3);
select * from employee;

insert into books values
(101,'Pride and Prejudice','Romance',28,'Yes','Jane Austen','T. Egerton'),
(102,'The Diary of a Young Girl','Memoir',18,'Yes','Anne Frank','Contact Publishing'),
(103,'The Great Adventure','Fiction', 26,'Yes','Alice Walker','Miya Publishers'),
(104, 'Science for All','Non-Fiction',40,'No','James Brown','Mary Press'),
(105, 'History of the World','History',35,'Yes','Mary Adams','History Books'),
(106,'The Alchemist','Adventure',30, 'No','Paulo Coelho','HarperOne');
select * from Books;

insert into customer values
(1001,'Samuel John','421,ABC Street,New York','2020-03-20'),
(1002,'Mariya Jacob','545,ABC Street,New York','2022-07-04'),
(1003,'Steffy','424,Oak Street,New York','2021-06-26'),
(1004,'Nivin Pauly','652,Washington Square,New York','2023-04-23'),
(1005,'Zara Jacob','421,Oyster Street,New York','2021-12-02');
select* from customer;

insert into issuestatus values
(1,1004,'The Great Adventure','2023-06-05', 103),
(2,1002,'Pride and Prejudice','2023-03-20', 101),
(3,1005,'The Diary of a Young Girl','2023-09-24', 102);
select * from issuestatus;

insert into returnstatus values
(1,1004,'The Great Adventure','2023-08-04', 103),
(2,1002,'Pride and Prejudice','2023-05-01', 101);
select * from returnstatus;

#1.Retrieve the book title, category, and rental price of all available books.
select book_title,category,rental_price from books where status = 'yes';

#2. List the employee names and their respective salaries in descending order of salary. 
select emp_name as Employee_Name,Salary from employee order by salary desc;

#3.Book titles and the corresponding customers who have issued those books.
select b.book_title, c.customer_name from books b
join issuestatus I on B.ISBN = I.ISBN_book
join customer c ON I.issued_cust = c.customer_Id;

#4.Total count of books in each category.
select category,count(*) as total_count_of_books from books group by category;

#5.Retrieve the employee names and their positions for the employees whose salaries are above Rs.50000.
select emp_name,position from employee where salary > 50000;

#6.Customer names who registered before 2022-01-01 and have not issued any books yet.
select customer_name from customer where Reg_date < '2022-01-01'
and customer_Id not in (select distinct Issued_cust from IssueStatus);

#7.Branch numbers and the total count of employees in each branch.
select branch_no,count(emp_id) as total_count_of_employee from employee group by branch_no;

#8.Display the names of customers who have issued books in the month of June 2023
select c.customer_name from customer c
join issuestatus I on c.customer_Id = I.issued_cust
where I.issue_date between '2023-06-01' and '2023-06-30';

#9.Retrieve book_title from the book table containing 'history'.
select book_title from books where book_title like '%history%';

#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
select E.Branch_no, count(E.Emp_Id) as Total_Employees from Employee E
group by E.Branch_no having count(E.Emp_Id) > 5;

#11.Retrieve the names of employees who manage branches and their respective branch addresses.
select Emp_name, B.Branch_address from Employee E
join Branch B on E.Branch_no = B.Branch_no where E.Position = 'Manager';

#12.Display the names of customers who have issued books with a rental price higher than Rs. 25. 
select C.Customer_name from Customer C
join IssueStatus I on C.Customer_Id = I.Issued_cust
join Books B on I.ISBN_book = B.ISBN where B.Rental_Price > 25;



