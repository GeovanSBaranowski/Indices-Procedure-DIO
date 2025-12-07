USE company_constraints;
show tables;

SELECT * FROM department;
SELECT * FROM employee;

-- Pergunta 1 Qual o departamento com maior número de pessoas?
-- Indice comum, apenas para localizar mais facilmente o Dno em employee e Dnumber em department

ALTER TABLE department ADD INDEX idx_Dnumber(Dnumber);
ALTER TABLE employee ADD INDEX idx_Edno_employee(Dno);

explain SELECT d.Dname, d.Dnumber, COUNT(*) AS total_employee FROM department AS d
	JOIN employee AS e ON e.Dno = d.Dnumber
    GROUP BY d.Dnumber, d.Dname
    ORDER BY total_employee DESC
    LIMIT 1;
    
---------------------------------------------------------------
-- Indice apenas no dept_locations, um simples, pois a primary key de department ja possui um indice automativcamente

SELECT * FROM department;
SELECT * FROM dept_locations;

ALTER TABLE dept_locations ADD INDEX idx_Dnumber_department(Dnumber);

explain SELECT D.Dname, l.Dlocation FROM department AS d
	JOIN dept_locations AS l ON l.Dnumber = d.Dnumber;
    
------------------------------------------------------------------
-- Indice composto para retornar o nome completo do employee, o Dnumber do departamente ja possui uma indice poor ser primary key

SELECT * FROM department;
SELECT * FROM employee;

ALTER TABLE employee ADD INDEX idx_completeName_employee(Fname, Minit, Lname);

SELECT CONCAT(Fname, ' ', Minit, ' ',  Lname) AS Name_employee, e.Ssn, d.Dname AS Department  FROM  employee AS e
	JOIN department AS d ON d.Dnumber = e.Dno;

