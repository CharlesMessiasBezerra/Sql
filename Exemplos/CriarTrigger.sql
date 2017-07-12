/*************************************************************************************
		Descrição: 
			

		Chamada por:
			
			
		DataBase:
		OBS:
			
		
**************************************************************************************/

if exists (select * from sysobjects where type = 'TR' and name = '<trigger_name>')
	begin
		print 'Removendo Trigger <trigger_name>'
		drop  trigger <trigger_name>
	end
go


print 'Criando Trigger <trigger_name>'
go

create trigger <trigger_name>
	on <table_name>/<view_name>
	
	for insert, update, delete 



go

grant exec on <trigger_name> to public

go
