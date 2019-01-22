-- Adicionando logins - usu�rios e grupos do Windows
sp_grantlogin "dros\Administrador"
-- Removendo logins - usu�rios e grupos do Windows
sp_revokelogin "dros\Administrador"
-- Criando logins standard do SQL
sp_addlogin "usuario","senha"
-- Removendo logins standard do SQL
sp_droplogin "usuario"
-- Visualizando logins do servidor
sp_helplogins
-- Visualizando cargos fixos do servidor
sp_helpsrvrole
-- Visualizando os cargos dos logins
sp_helpsrvrolemember
-- Visualizando quais os logins que possuem um determinado cargo
sp_helpsrvrolemember "dbcreator"
-- Visualizando quais comandos podem ser executados pelos usu�rios que possuem um determinado cargo
sp_srvrolepermission dbcreator
-- Definindo um cargo do servidor a um login
sp_addsrvrolemember "usuario","db_datawriter"
-- Visualizando os usu�rios do banco de dados
sp_helpuser
-- Definindo logins como usu�rios do banco de dados (3 modos de defini��o)
sp_adduser usuario,usuario, db_owner
sp_grantdbaccess usuario,usuario
sp_adduser usuario,usuario
-- Excluindo usu�rios do banco de dados (2 modos de exclus�o)
sp_revokedbaccess usuario
sp_dropuser usuario
-- Visualizando cargos fixos do banco de dados
sp_helpdbfixedrole
-- Visualizando cargos e grupos do banco de dados
sp_helpgroup
sp_helprole
-- Criando cargos e grupos no banco de dados
sp_addgroup "adm"
sp_addrole "admusr"
-- Removendo cargos e grupos do banco de dados
sp_dropgroup "adm"
sp_droprole
-- Retornando os atributos de um cargo
sp_dbfixedrolepermission "db_ddladmin"
-- Adicionando usu�rios a cargos e grupos do banco de dados
sp_addrolemember "adm","usuario"
sp_addrolemember "admusr","usuario"
-- Visualizando os usu�rios que possuem um determinado cargo
sp_helpuser "admusr"
-- Removendo o usu�rio de um cargo ou grupo
sp_droprolemember "admusr","usuario"

--Definindo permiss�es de objeto: � select, insert, delete, update, references, exec�

-- Visualizando as permiss�es em uma tabela
sp_helprotect "carros","usuario"
-- Permitindo ao usu�rio a execu��o do comando select
grant select on carros to usuario
grant select,insert on carros to usuario1
-- Permitindo ao usu�rio a execu��o do comando insert
grant insert on carros to usuario
-- Retirando as permiss�es do usu�rio
revoke all on carros to usuario
-- Atribuindo permiss�es de select ou update em apenas algumas colunas da tabela
grant select (placa) on carros to usuario
-- Negando permiss�es de um comando a um grupo
deny select on alunos to admusr
