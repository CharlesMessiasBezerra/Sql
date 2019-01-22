if exists (select * from sysobjects where type IN ('TF','FN') and name = 'fn_formatarTelefone')
	begin
		print 'Removendo Function fn_formatarTelefone'
		drop function fn_formatarTelefone
	end
go

print 'Criando Function fn_formatarTelefone'
go

CREATE FUNCTION fn_formatarTelefone(@Telefone varchar(12))

RETURNS VARCHAR(15)

AS

BEGIN 

DECLARE @retorno VARCHAR(15)
DECLARE @str_telefone varchar (24)

	SET @str_telefone = RIGHT('000000000000' + @Telefone,12)

	SET @retorno = '(' + substring(@str_telefone ,1,4) + ')' + substring(@str_telefone ,5,4) + '-' + substring(@str_telefone ,9,4) 
	     
	RETURN @retorno

END
go

