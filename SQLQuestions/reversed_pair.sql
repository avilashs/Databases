-- remove all reversed pair numbers from tbale and keep one
create table number_pairs(A int, B int);
insert into number_pairs values(1,2);
insert into number_pairs values(3,2);
insert into number_pairs values(2,4);
insert into number_pairs values(2,1);
insert into number_pairs values(5,6);
insert into number_pairs values(4,2);


select a.a,a.b from 
number_pairs a,
number_pairs b
where 
a.a = b.b(+) and 
a.b = b.a(+) and 
(b.a is null or a.a < b.a);


select * from number_pairs a
where 
not exists 
(
select 1 from number_pairs b where a.a= b.b and b.a=a.b and a.a < b.a
);

with tmp AS(
  SELECT A,B ,row_number() OVER(Partition By A+B,A*B ORDER BY A) as rn
  FROM number_pairs)
  Select * from tmp where rn=1;
  
  insert into number_pairs values(5,5);
  insert into number_pairs values(4,6);
