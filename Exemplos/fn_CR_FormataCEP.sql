IF EXISTS(SELECT name FROM sys.all_objects WHERE name = 'fn_CR_FormataCEP')
	BEGIN
		print 'Excluindo função fn_CR_FormataCEP '
		DROP FUNCTION dbo.fn_CR_FormataCEP
	END
go

print 'criando função fn_CR_FormataCEP '

go 

CREATE FUNCTION dbo.fn_CR_FormataCEP( @str_Cep VARCHAR(8) )
	RETURNS VARCHAR(9)
 AS

BEGIN
	DECLARE @str_Regiao VARCHAR(5)
	DECLARE @str_setor VARCHAR(3)
	DECLARE @str_CepFormatado VARCHAR(9)

IF( LEN( @str_Cep ) = 0 )
	RETURN 'N/C'
 
SET @str_Regiao = SUBSTRING( @str_Cep, 0, 6 )
SET @str_setor = SUBSTRING( @str_Cep, 6, 3 )
SET @str_CepFormatado = @str_Regiao +	'-' + @str_setor
 
RETURN( @str_CepFormatado )
 END