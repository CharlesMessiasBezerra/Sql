/**********************************************************************
		Descrição: 
			
			
		Chamada por:
			

		DataBase: 
		OBS: 
			
			
**********************************************************************/

if exists (select * from sysobjects where type = 'p' and name = 'Sp_mng_cadastro')
	begin
		print 'Removendo Procedure Sp_mng_cadastro'
		drop procedure Sp_mng_cadastro
	end
go

print 'Criando Procedure Sp_mng_cadastro'
go
					

create PROCEDURE Sp_mng_cadastro 

@idsecao INT 

AS 


go

grant exec on Sp_mng_cadastro to public

go