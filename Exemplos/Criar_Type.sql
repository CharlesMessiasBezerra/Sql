/***************************************************************************************************************
		Descrição: Criar_Type_udtIdData
		drop TYPE [dbo].[typeParameter] 
****************************************************************************************************************/
if not exists (select * from sys.types st join sys.schemas ss on st.schema_id = ss.schema_id where st.name = N'typeParameter' and ss.name = N'dbo')
	begin

CREATE TYPE typeParameter AS TABLE(
	Id int NOT NULL
)

	end
go


