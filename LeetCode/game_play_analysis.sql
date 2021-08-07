#leetcode game play analysis
/*
Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) 
before logging out on some day using some device.
 
Write an SQL query that reports the first login date for each player.
The query result format is in the following example:
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Result table:
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
*/

-- Q1 : Write an SQL query that reports the first login date for each player.


select 
player_id,
min(event_date) first_login
from 
Activity
group by 
player_id;

-- Q2 : Write a SQL query that reports the device that is first logged in for each player.



with tmp as
(
select 
	player_id,
	min(event_date) first_login
from 
	Activity
group by 
	player_id
)
select 
	a.player_id,
	a.device_id 
from 
	Activity a,
	tmp t
where 
	a.player_id = t.player_id and 
	a.event_date = t.first_login;


-- Q3: Write an SQL query that reports for each player and date, how many games played so far by the player. That is, the total number of games played by the player until that date. 
select 
player_id,
event_date,
sum() over (partition by player_id order by event_date) running_total
from 
 Activity;

-- Q4 : Write an SQL query that reports the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 

with tmp as 
(
select 
	player_id,
	min(event_date) min_e_d
from 
	Activity
group by 
	player_id
)
select 
round(sum(decode(event_date,
		min_e_d+1,1,0))/count(distinct a.player_id),2)
from 
Activity a,
tmp b
where a.player_id = b.player_id;


