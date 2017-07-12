/******************************************************************************

		Descrição: Script para formatar o cnpj/cpf

            
		Chamada por: Quem quiser chamar(serve para formalizar qualquer 
		saída via script do sql server).
            

*******************************************************************************/

if exists (select * from sysobjects where type IN ('TF','FN') and name = 'fn_CR_FormatarInscricaoEstadual')
	begin
		print 'Removendo Function fn_CR_formatarInscricaoEstadual'
		drop function fn_CR_formatarInscricaoEstadual
	end
go

print 'Criando Function fn_CR_formatarInscricaoEstadual'
go

CREATE FUNCTION fn_CR_formatarInscricaoEstadual(@InscricaoEstadual varchar(14))

RETURNS VARCHAR(18)

AS

BEGIN DECLARE @retorno VARCHAR(18)
	--CNPJ
	IF LEN(@InscricaoEstadual)= 12 
		
		BEGIN
			SET @retorno = substring(@InscricaoEstadual ,1,3) + '.' + substring(@InscricaoEstadual ,4,3) + '.' + substring(@InscricaoEstadual ,7,3) + '.' + substring(@InscricaoEstadual ,10,3) 
		END
	--CPF
	ELSE
		BEGIN
			SET @retorno = ''
		END
     
	RETURN @retorno

END
go

	
go
