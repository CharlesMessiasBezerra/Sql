IF EXISTS(SELECT name FROM sys.all_objects WHERE name = 'Fn_CR_RetornaMesExtenso')
	BEGIN
		print 'Excluindo função Fn_CR_RetornaMesExtenso '
		DROP FUNCTION dbo.Fn_CR_RetornaMesExtenso
	END
go

print 'criando função Fn_CR_RetornaMesExtenso '

go 

    CREATE FUNCTION Fn_CR_RetornaMesExtenso (@DATA DATETIME) RETURNS VARCHAR (20)  
    AS
    BEGIN
      DECLARE @MES INT,   
        @MES_EXT VARCHAR(20)
  
      SELECT @MES = (MONTH(@DATA ))

      IF @MES=01 
        SET @MES_EXT ='JANEIRO'
      IF @MES=02  
         SET @MES_EXT ='FEVEREIRO'
      IF @MES=03  
         SET @MES_EXT ='MARCO'
      IF @MES=04  
         SET @MES_EXT ='ABRIL'
      IF @MES=05  
         SET @MES_EXT ='MAIO'
      IF @MES=06  
         SET @MES_EXT ='JUNHO'
      IF @MES=07  
         SET @MES_EXT ='JULHO'
      IF @MES=08  
         SET @MES_EXT ='AGOSTO'
      IF @MES=09  
         SET @MES_EXT ='SETEMBRO'
      IF @MES=10  
         SET @MES_EXT ='OUTUBRO'
      IF @MES=11 
         SET @MES_EXT ='NOVEMBRO'
      IF @MES=12  
         SET @MES_EXT ='DEZEMBRO'

      RETURN @MES_EXT
    END