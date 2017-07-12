/******************************************************************************
		Descrição: 
			
            
		Chamada por:
            
			
		DataBase:
		OBS:
			
			
*******************************************************************************/

if exists (select * from sysobjects where type = 'FN' and name = '<function_name>')
	begin
		print 'Removendo Function <function_name>'
		drop function <function_name>
	end
go

print 'Criando Function <function_name>'
go

create function <function_name>
(
	<parameters_function>
)
	returns <type_function>
as	
begin
	

	return <return_function>
end
go