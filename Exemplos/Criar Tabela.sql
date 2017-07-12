/**********************************************************************
		Descrição: 
			
		OBS: 
						
**********************************************************************/

if not exists (select * from sys.tables where name = '<table_name>')
	begin
		print 'Criando Tabela <table_name>'

		/* Colocar código da criação da tabela sem o 'Go' no final das instruções */
		
	end
go