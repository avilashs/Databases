/*
Problem
The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.


+------+----------+-----------+----------+
|Id    |Name 	  |Department |ManagerId |
+------+----------+-----------+----------+
|101   |John 	  |A 	      |null      |
|102   |Dan 	  |A 	      |101       |
|103   |James 	  |A 	      |101       |
|104   |Amy 	  |A 	      |101       |
|105   |Anne 	  |A 	      |101       |
|106   |Ron 	  |B 	      |101       |
+------+----------+-----------+----------+
Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table, your SQL query should return:

1
2
3
4
5
+-------+
| Name  |
+-------+
| John  |
+-------+
Note:
No one would report to himself.
*/


select 
e.name from 
Employee e,
employee e1
where 
e.id = e.managerid
group by 
e1.managerid
having  count(*) >4;

select name from employee 
where id in 
(
select managerid from Employee
group by 
managerid
having count(*) > 4
);