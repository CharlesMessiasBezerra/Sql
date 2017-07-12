/**********************************************************************
		Descrição: 
			
					
		OBS: 
						
**********************************************************************/

if not exists (select * from syscolumns where id = object_id('<table_name>') and name in('<column_name>'))
	begin
		print 'Criando a(s) coluna(s) (<column_name>, <column_name>)'
		
		/* Colocar código da criação das colunas sem o 'Go' no final das instruções */

	end
go
