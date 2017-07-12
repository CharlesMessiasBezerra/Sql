/******************************************************************************

		Descrição: Script para formatar o cnpj/cpf

            
		Chamada por: Quem quiser chamar(serve para formalizar qualquer 
		saída via script do sql server).
            

*******************************************************************************/

if exists (select * from sysobjects where type IN ('TF','FN') and name = 'fn_formatarCNPJCPF')
	begin
		print 'Removendo Function fn_formatarCNPJCPF'
		drop function fn_formatarCNPJCPF
	end
go

print 'Criando Function fn_formatarCNPJCPF'
go

CREATE FUNCTION fn_formatarCNPJCPF(@CnpjCpf varchar(14))

RETURNS VARCHAR(18)

AS

BEGIN DECLARE @retorno VARCHAR(18)
	--CNPJ
	IF LEN(@CnpjCpf)= 14 
		
		BEGIN
			SET @retorno = substring(@CnpjCpf ,1,2) + '.' + substring(@CnpjCpf ,3,3) + '.' + substring(@CnpjCpf ,6,3) 
							+ '/' + substring(@CnpjCpf ,9,4) + '-' + substring(@CnpjCpf ,13,2)
		END
	--CPF
	ELSE
		BEGIN
			SET @retorno = substring(@CnpjCpf ,1,3) + '.' + substring(@CnpjCpf ,4,3) + '.' + substring(@CnpjCpf ,7,3) 
							+ '-' + substring(@CnpjCpf ,10,2) 
		END
     
	RETURN @retorno

END
go

	
go
