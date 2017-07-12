/*************************************************************************************
		Descrição: 
			
			
		Chamada por:
            
			
		DataBase: 
		OBS:
			
		 
**************************************************************************************/

if exists (select * from sysobjects where type = 'V' and name = 'vw_Pedidos_de_venda_Pendentes_Por_Laboratorio')
	begin
		print 'Removendo View vw_Pedidos_de_venda_Pendentes_Por_Laboratorio'
	    drop view vw_Pedidos_de_venda_Pendentes_Por_Laboratorio
	end
go

print 'Criando View vw_Pedidos_de_venda_Pendentes_Por_Laboratorio'
go
create view vw_Pedidos_de_venda_Pendentes_Por_Laboratorio  
as  
  SELECT   
    a.IdMovimento,  
    b.NomeEmpresa,  
    d.Descrição,  
    a.NúmeroDocumento AS NúmeroPedido,  
    a.DataMovimento  AS DataMov_Filtro,  
    a.DataEmissão AS DataEmissão_Filtro,
    a..IdCadastro AS IdCadastro_Filtro,
    a.DataEmissão,  
    b.Codinome,  
    c.PedidoCompra,  
    c.ValorUnitárioUsado,  
    c.QuantidadeFaturada,   
    c.QuantidadeBloqueada,  
    c.IdItem,  
    e.marca,  
    a.IdEmpresa AS IdEmpresa_Filtro,
    (CASE   
		  WHEN a.Ped_Percentual_Faturado = 0 OR a.Ped_Percentual_Faturado IS NULL   
			  THEN 0   
		  ELSE a.Ped_Percentual_Faturado   
	  END) AS PercFaturado ,
    c.QuantidadeUsada    ,
    f.int_NumeroEmpenho  
FROM   
  mov_estoque AS a   
	  INNER JOIN   
	Tab_Cadastro AS b   
	    ON a.IdCadastro = b.Codinome  
		INNER JOIN   
	Mov_Estoque_Detalhes AS c  
			ON c.IdMovimento = a.IdMovimento  
		INNER JOIN   
  Tab_Estoque AS d   
			ON d.IdItem = c.IdItem  
		INNER JOIN   
	Tab_Estoque_Marcas AS e  
			ON d.IdMarca = e.IdMarca  
		inner join
	Mov_Estoque_Complementos as f
			on f.fk_int_IdMovimento 	=	a.idmovimento																																																																																			
WHERE 
  ClassificaçãoMovimento = 13 AND 
	a.Ped_Pendente_Liberado = 0 AND 
	c.PendenteLiberado = 0 AND
	isnull(a.idcancelamento,0) = 0 and 
	f.bit_NaoBaixaSaldo = 0

  

go
    grant select on vw_CR_EstoquePorGrupoAnalítico to public

go