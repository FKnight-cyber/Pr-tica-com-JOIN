--Q1 Utilizando uma query, obtenha todos os usuários 
--(users) que vivem na cidade (cities) cujo nome seja “Rio de Janeiro”.

SELECT u.id,u.name,c.name as city 
FROM users u 
JOIN cities c 
ON u."cityId" = c.id 
WHERE c.name ILIKE 'Rio de Janeiro';

--Q2 Utilizando umas query, obtenha todos os depoimentos 
--(testimonials) cadastrados, incluindo o nome do remetente e do destinatário.

SELECT t.id,writer.name as writer,recipient.name as recipient, t.message
FROM testimonials t
JOIN users writer
ON t."writerId" = writer.id
JOIN users recipient
ON t."recipientId" = recipient.id;

--Q3 Utilizando uma query, obtenha todos os cursos (courses) 
--que o usuário com id 30 já finalizou, incluindo o nome da escola. 
--O que indica que um usuário terminou um curso é o campo status da tabela educations, 
--que deve estar como "finished".

SELECT e."userId" as id,u.name,c.name as course,s.name as school,e."endDate"
FROM educations e
JOIN users u
ON e."userId" = u.id
JOIN courses c
ON e."courseId" = c.id
JOIN schools s
ON e."schoolId" = s.id
WHERE e."userId" = 30
AND e.status ILIKE 'finished';

--Q4 Utilizando uma query, obtenha as empresas (companies) 
--para as quais o usuário com id 50 trabalha atualmente. 
--Para filtrar quem trabalha atualmente, utilize o campo endDate da tabela experiences. 
--Se ele estiver null (IS NULL), significa que a pessoa ainda não encerrou a experiência
--dela na empresa, ou seja, está trabalhando lá.

SELECT u.id as id, u.name, r.name as role, c.name as company, e."startDate"
FROM companies c
JOIN experiences e
ON c.id = e."companyId"
JOIN jobs j
ON c.id = j."companyId"
JOIN applicants a
ON j.id = a."jobId"
JOIN users u
ON u.id = 50
JOIN roles r
ON j."roleId" = r.id
WHERE e."endDate" IS NULL;

--### Desafio Bônus
--Utilizando uma *query*, obtenha a lista das diferentes escolas (`schools`)
--e cursos (`courses`) onde estudaram as pessoas que estão aplicando pra posição de 
--**“Software Engineer”** na empresa com id **10**. Só devem ser consideradas as vagas
--que estiverem ativas, ou seja, quando o campo `active` da tabela `jobs` estiver **true**.

SELECT s.id,s.name as school, course.name as course,company.name as company,r.name as role
FROM users u
JOIN educations ed
ON u.id = ed."userId"
JOIN schools s
ON ed."schoolId" = s.id
JOIN courses course
ON ed."courseId" = course.id
JOIN applicants appl
ON u.id = appl."userId"
JOIN jobs j
ON appl."jobId" = j.id
JOIN companies company
ON j."companyId" = company.id
JOIN roles r
ON j."roleId" = r.id
WHERE company.id = 10
AND j.active = true
AND r.name ILIKE 'Software Engineer';