USE azure_company;
-- LEFT JOIN conserva todos os colaboradores e o superior nulo do líder.
SELECT e.Ssn AS EmployeeId, CONCAT_WS(' ',e.Fname,e.Minit,e.Lname) AS Nome,
 d.Dname AS Departamento, e.Salary AS Salario,
 e.Super_ssn AS ManagerId, CONCAT_WS(' ',m.Fname,m.Minit,m.Lname) AS Gerente
FROM employee e
LEFT JOIN departament d ON e.Dno=d.Dnumber
LEFT JOIN employee m ON e.Super_ssn=m.Ssn;

SELECT CONCAT_WS(' ',m.Fname,m.Minit,m.Lname) AS Gerente, COUNT(*) AS ColaboradoresDiretos
FROM employee e JOIN employee m ON e.Super_ssn=m.Ssn
GROUP BY m.Ssn,m.Fname,m.Minit,m.Lname;

SELECT d.Dnumber, CONCAT(d.Dname,' - ',l.Dlocation) AS DepartamentoLocal
FROM departament d LEFT JOIN dept_locations l ON d.Dnumber=l.Dnumber;

SELECT p.Pname, SUM(w.Hours) AS Horas FROM project p
LEFT JOIN works_on w ON p.Pnumber=w.Pno GROUP BY p.Pnumber,p.Pname;
SELECT COUNT(*) AS Colaboradores, SUM(Salary) AS Folha FROM employee; -- 8 / 281000
SELECT COUNT(*) AS Alocacoes, SUM(Hours) AS Horas FROM works_on; -- 16 / 275
SELECT * FROM employee WHERE Super_ssn IS NULL; -- James E Borg
SELECT d.* FROM departament d LEFT JOIN employee e ON d.Mgr_ssn=e.Ssn WHERE e.Ssn IS NULL; -- 0
SELECT * FROM works_on WHERE Hours=0; -- James / Reorganization
