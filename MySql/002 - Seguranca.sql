-----------------------------------------------------------------
-- 1 - para o bd empresa, criar um usuario financeior
-----------------------------------------------------------------

create user Financeiro@localhost identified by '1234';
create user Gestor@localhost identified by '1234';
show databases;

-- visualiza permissoes
SHOW GRANTS FOR Financeiro@localhost; 
SHOW GRANTS FOR Gestor@localhost; 

-----------------------------------------------------------------
-- removendo permicao do usuario financeiro 
-----------------------------------------------------------------
use empresa;
select * from empregado;

-- removendo permissoes do bd empresa
revoke SELECT  on  empresa.* FROM Financeiro@localhost;

GRANT all on  empresa.empregado  to Gestor@localhost;
revoke select on  empresa.log from Gestor@localhost;


-- adicionando permissao select na tab_empresacola pnome
 GRANT select  (PNOME) on  empresa.empregado  to Financeiro@localhost;
 GRANT select  (UNOME) on  empresa.empregado  to Financeiro@localhost;

--
revoke all on  empresa.bonus FROM Financeiro@localhost;
GRANT select  on  empresa.bonus to Financeiro@localhost;


