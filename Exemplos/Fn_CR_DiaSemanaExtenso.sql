IF EXISTS(SELECT name FROM sys.all_objects WHERE name = 'Fn_CR_DiaSemanaExtenso')
	BEGIN
		print 'Excluindo função Fn_CR_DiaSemanaExtenso '
		DROP FUNCTION dbo.Fn_CR_DiaSemanaExtenso
	END
go

print 'criando função Fn_CR_DiaSemanaExtenso '

go 

    CREATE FUNCTION Fn_CR_DiaSemanaExtenso (@DATA DATETIME) RETURNS VARCHAR (20)  
    AS
    BEGIN
      DECLARE 
        @DIA INT,   
        @DIA_EXT VARCHAR(20)
  
      SELECT @DIA = (DATEPART(DW,@DATA ))

      IF @DIA=1 
        SET @DIA_EXT ='DOMINGO'
      IF @DIA=2  
         SET @DIA_EXT ='SEGUNDA-FEIRA'
      IF @DIA=3  
         SET @DIA_EXT ='TERÇA-FEIRA'
      IF @DIA=4  
         SET @DIA_EXT ='QUARTA-FEIRA'
      IF @DIA=5  
         SET @DIA_EXT ='QUINTA-FEIRA'
      IF @DIA=6  
         SET @DIA_EXT ='SEXTA-FEIRA'
      IF @DIA=7  
         SET @DIA_EXT ='SÁBADO'

      RETURN @DIA_EXT
    END