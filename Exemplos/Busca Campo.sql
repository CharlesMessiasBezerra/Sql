select 
	a.name as coluna,
	b.name as tabela,
  'select ' + a.name + ',* from ' +	b.name as pesquisa
from 
	syscolumns as a
		INNER JOIN 
	sys.tables as b
			ON b.object_id = a.id  
where 
	a.name like('%maxcon%') 
	--and b.name in ('Tab_Estoque')


