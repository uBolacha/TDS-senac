 -- 1. Escreva uma consulta SQL para buscar “FIRST_NAME” da tabela Worker usando o nome do alias como <WORKER_NAME>.--
SELECT (FIRST_NAME) AS WORKER_NAME FROM worker;

-- 2. Escreva uma consulta SQL para buscar “FIRST_NAME” da tabela Worker em maiúsculas. --
SELECT UPPER(FIRST_NAME) FROM WORKER;

-- 3. Escreva uma consulta SQL para buscar valores exclusivos de DEPARTMENT da tabela Worker. --
SELECT distinct(DEPARTMENT) FROM WORKER;

-- 4. Escreva uma consulta SQL para imprimir os três primeiros caracteres de FIRST_NAME da tabela Worker. --
SELECT substring(FIRST_NAME,1, 3) FROM WORKER;

-- 5. Escreva uma consulta SQL para imprimir o FIRST_NAME da tabela Worker após remover os espaços em branco do lado direito. -- 
SELECT RTRIM(FIRST_NAME) FROM WORKER;

-- 6. Escreva uma consulta SQL para imprimir a tabela DEPARTMENT from Worker após remover os espaços em branco do lado esquerdo. --
SELECT LTRIM(DEPARTMENT) FROM WORKER;

-- 7. Escreva uma consulta SQL que busque os valores exclusivos de DEPARTMENT da tabela Worker e imprima seu comprimento. --
 SELECT distinct(LENGTH(DEPARTMENT)) FROM WORKER;
 
 -- 8. Escreva uma consulta SQL para selecionar o FIRST_NAME da tabela Worker após substituir 'a' por 'A'. -- 
select REPLACE(FIRST_NAME,'a','A') FROM WORKER;

-- 9. Faça uma consulta SQL para selecionar o FIRST_NAME e LAST_NAME da tabela Worker em uma única coluna chamada COMPLETE_NAME. Um caractere de espaço deve separá-los.

SELECT CONCAT(FIRST_NAME," ", LAST_NAME) AS COMPLETE_NAME FROM WORKER;

-- 10. Escreva uma consulta SQL para imprimir todos os detalhes do Worker da ordem da tabela Worker por FIRST_NAME ascendente. -- 
 
 SELECT * FROM WORKER ORDER BY FIRST_NAME ASC;
 
 -- 11. Escreva uma consulta SQL para imprimir todos os detalhes do Worker da tabela Worker ordenados por FIRST_NAME ascendente e DEPARTMENT descendente na mesma query. --
 
 SELECT * FROM WORKER
 ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;
 
 -- 12. Escreva uma consulta SQL para trazer detalhes de trabalhadores com nome de departamento como “Admin”. --
 
 SELECT*FROM WORKER WHERE DEPARTMENT = "admin" ;
 
 -- 13. Escreva uma consulta SQL para imprimir detalhes dos trabalhadores cujo FIRST_NAME contém 'a'. --
 
 SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%a%';
 
 -- 14. Escreva uma consulta SQL para imprimir detalhes dos trabalhadores cujo FIRST_NAME termina com 'a'.--
 
 SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%a';
 
 -- 15. Escreva uma consulta SQL para imprimir detalhes dos trabalhadores cujo salário esteja entre 100.000 e 500.000. --
 
 SELECT*FROM WORKER
 WHERE SALARY BETWEEN 100000 AND 500000;
 
 -- 16. Escreva uma consulta SQL para selecionar detalhes dos trabalhadores que ingressaram em fevereiro de 2014. --

SELECT * FROM WORKER WHERE JOINING_DATE BETWEEN '14-02-01' AND '14-02-28';

-- 17. Escreva uma consulta SQL para buscar a contagem de funcionários que trabalham no departamento 'Admin'. -- 

SELECT COUNT(*) FROM WORKER WHERE DEPARTMENT = 'admin';

-- 18. Escreva uma consulta SQL para buscar nomes de trabalhadores com salários >= 50.000 e <= 100.000. -- 

SELECT * FROM WORKER
WHERE SALARY BETWEEN '50000' AND '100000';

-- 19. Escreva uma consulta SQL para buscar o número de trabalhadores para cada departamento em ordem decrescente. -- 

select department, COUNT(WORKER_ID)  AS QUANTIDADE FROM WORKER 
GROUP BY DEPARTMENT ORDER BY QUANTIDADE DESC;

-- 20. Escreva uma consulta SQL para imprimir detalhes dos trabalhadores que também são gerentes (managers) -- 

SELECT * FROM WORKER INNER JOIN TITLE ON WORKER.WORKER_ID = TITLE.WORKER_REF_ID
WHERE TITLE.WORKER_TITLE LIKE 'manager';

-- 21. Escreva uma consulta SQL para buscar registros duplicados com dados correspondentes em alguns campos de uma tabela. --

SELECT WORKER_TITLE, AFFECTED_FROM, COUNT(*) FROM TITLE
GROUP BY WORKER_TITLE, AFFECTED_FROM 
HAVING COUNT(*) >1;

-- 22. Escreva uma consulta SQL para mostrar a data e hora atuais -- 

SELECT CURDATE();

-- 23. Escreva uma consulta SQL para buscar os departamentos que têm menos de cinco pessoas. --

SELECT DEPARTMENT, COUNT(WORKER_ID) AS 'number of workers' 
FROM WORKER
GROUP BY DEPARTMENT HAVING COUNT(WORKER_ID) > 5;

-- 24. Escreva uma consulta SQL para imprimir o nome dos funcionários com o salário mais alto em cada departamento. -- 

SELECT T.DEPARTMENT, T.FIRST_NAME, T.SALARY FROM 
(SELECT MAX(SALARY) AS TOTALSALARY, DEPARTMENT FROM WORKER
GROUP BY DEPARTMENT) AS tempNEW 
INNER JOIN WORKER T ON tempNEW.DEPARTMENT = T.DEPARTMENT
AND tempNEW.TotalSalary = t.SALARY;


-- 25. Escreva uma consulta SQL para mostrar apenas as linhas ímpares de uma tabela. -- 

SELECT * FROM WORKER WHERE MOD (WORKER_ID,2) <> 0 ;

-- 26. Escreva uma consulta SQL para mostrar apenas as linhas pares de uma tabela. --

SELECT * FROM WORKER WHERE MOD (WORKER_ID,2)=0;

-- 27. Escreva uma consulta SQL para mostrar os principais n (digamos 10) registros de uma tabela. -- 

SELECT * FROM WORKER ORDER BY SALARY DESC LIMIT 10;

-- 28. Escreva uma consulta SQL para determinar o 5º salário mais alto sem usar o método limit. -- 

SELECT DISTINCT SALARY FROM WORKER w1
WHERE 5 = ( SELECT COUNT(DISTINCT(W2.SALARY))
FROM WORKER w2 WHERE w2.SALARY >= w1.SALARY);

-- 29. Escreva uma consulta SQL para buscar a lista de funcionários com o mesmo salário. -- 

SELECT DISTINCT SALARY FROM WORKER 
GROUP BY SALARY 
HAVING COUNT(SALARY) > 1;

-- 30. Escreva uma consulta SQL para mostrar o segundo maior salário de uma tabela. --

SELECT MAX(SALARY) FROM WORKER
WHERE SALARY NOT IN (SELECT MAX(SALARY)FROM WORKER);

-- 31. Escreva uma consulta SQL para mostrar uma linha duas vezes nos resultados de uma tabela. -- 

SELECT FIRST_NAME, DEPARTMENT FROM WORKER W WHERE W.DEPARTMENT = 'HR'
UNION ALL
SELECT FIRST_NAME, DEPARTMENT FROM WORKER W1 WHERE W1.DEPARTMENT = 'HR';

-- 32.  Escreva uma consulta SQL para buscar os departamentos que têm menos de cinco pessoas. --

SELECT DEPARTMENT, COUNT(WORKER_ID) FROM WORKER GROUP BY DEPARTMENT HAVING COUNT(WORKER_ID);

-- 33. Escreva uma consulta SQL para mostrar todos os departamentos junto com o número respectivo de pessoas. --

SELECT DEPARTMENT, COUNT(WORKER_ID) FROM WORKER GROUP BY DEPARTMENT;

-- 34. Escreva uma consulta SQL para mostrar o último registro de uma tabela. --

SELECT * FROM WORKER WHERE WORKER_ID = (SELECT MAX(WORKER_ID) FROM WORKER); 

-- 35.Escreva uma consulta SQL para buscar os últimos cinco registros de uma tabela. --

SELECT*FROM WORKER WHERE WORKER_ID<=5 
UNION
SELECT*FROM (SELECT * FROM WORKER W ORDER BY W.WORKER_ID DESC) AS W1
WHERE W1.WORKER_ID <=5;

-- 36. Escreva uma consulta SQL para imprimir o nome dos funcionários com o salário mais alto em cada departamento. --

SELECT T.DEPARTMENT,T.FIRST_NAME,T.SALARY
FROM
(SELECT MAX(SALARY) AS TOTAL_SALARY, DEPARTMENT FROM WORKER GROUP BY DEPARTMENT) AS TEMPNEW
INNER JOIN WORKER T ON TEMPNEW.DEPARTMENT=T.DEPARTMENT
AND TEMPNEW.TOTAL_SALARY = T.SALARY;
