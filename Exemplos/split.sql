/******************************************************************************
		Descrição: 
			
            
		Chamada por:
            
			
		DataBase:
		OBS:
		
			
*******************************************************************************/

if exists (select * from sysobjects where type in ('TF','FN') and name = 'fn_Split')
	begin
		print 'Removendo Function fn_Split'
		drop function fn_Split
	end
go

print 'Criando Function fn_Split'
go


create FUNCTION dbo.fn_Split(@str_frase VARCHAR(max),	@str_delimitador VARCHAR(max) = ',')

RETURNS @tab_result TABLE (item VARCHAR(8000))

BEGIN
	DECLARE @parte VARCHAR(8000)

WHILE CHARINDEX(@str_delimitador,@str_frase,0) <> 0
	BEGIN
		SELECT
			@parte=RTRIM(LTRIM(SUBSTRING(@str_frase,1,CHARINDEX(@str_delimitador,@str_frase,0)-1))),
			@str_frase=RTRIM(LTRIM(SUBSTRING(@str_frase,CHARINDEX(@str_delimitador,@str_frase,0)+LEN(@str_delimitador),LEN(@str_frase))))

	IF LEN(@parte) > 0
		INSERT INTO @tab_result SELECT @parte
	END

	IF LEN(@str_frase) > 0
		INSERT INTO @tab_result SELECT @str_frase
	RETURN

END
GO

