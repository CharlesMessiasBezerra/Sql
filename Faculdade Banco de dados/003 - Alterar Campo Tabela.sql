ALTER TABLE dbo.cliente ADD str_nome_new nvarchar(500) NULL
go

UPDATE dbo.cliente set str_nome_new = str_nome
go

ALTER TABLE dbo.cliente DROP COLUMN str_nome
go

EXEC sp_rename 'cliente.str_nome_new', 'str_nome', 'COLUMN'

