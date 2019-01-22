/*************************************************************************************
		Descrição: 
			
			
		Chamada por:
            
			
		DataBase: 
		OBS:
			
		 
**************************************************************************************/

if exists (select * from sysobjects where type = 'V' and name = 'vw_Pedidos')
	begin
		print 'Removendo View vw_Pedidos'
	    drop view vw_Pedidos
	end
go

print 'Criando View vw_Pedidos'
go
create view vw_Pedidos  
as  
  SELECT   from cadastro
   

  

go
    grant select on vw_CR_EstoquePorGrupoAnalítico to public

go