-- Print prime numbers from 1..1000
-- Print as column and then print as comma separated 
SELECT (A.Numerator)
        FROM (SELECT LEVEL AS Numerator FROM DUAL CONNECT BY LEVEL <= 1000) A
           , (SELECT LEVEL AS Denominator FROM DUAL WHERE LEVEL > 1 CONNECT BY LEVEL <= 1000) B
       WHERE A.Numerator >= B.Denominator
         AND MOD(A.Numerator , B.Denominator) = 0
       GROUP BY A.Numerator
    having count(*) <= 1
    order by numerator;

select 
substr(sys.stragg(','||numerator),2) val from 
(SELECT (A.Numerator)
        FROM (SELECT LEVEL AS Numerator FROM DUAL CONNECT BY LEVEL <= 1000) A
           , (SELECT LEVEL AS Denominator FROM DUAL WHERE LEVEL > 1 CONNECT BY LEVEL <= 1000) B
       WHERE A.Numerator >= B.Denominator
         AND MOD(A.Numerator , B.Denominator) = 0
       GROUP BY A.Numerator
    having count(*) <= 1
    order by numerator
);
