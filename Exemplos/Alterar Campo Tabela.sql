ALTER TABLE dbo.ModeloEmailLicitacao ADD str_PathArquivo_new nvarchar(500) NULL
go

UPDATE dbo.ModeloEmailLicitacao set str_PathArquivo_new = str_PathArquivo
go

ALTER TABLE dbo.ModeloEmailLicitacao DROP COLUMN str_PathArquivo
go

EXEC sp_rename 'ModeloEmailLicitacao.str_PathArquivo_new', 'str_PathArquivo', 'COLUMN'

