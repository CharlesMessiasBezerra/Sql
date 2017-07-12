/**********************************************************************
		Descrição: 
			
			
		Chamada por:
			

		DataBase: 
		OBS: 
			
			
**********************************************************************/

if exists (select * from sysobjects where type = 'p' and name = 'Sp_mng_rel_rentabilidade_grupo2_bonif')
	begin
		print 'Removendo Procedure Sp_mng_rel_rentabilidade_grupo2_bonif'
		drop procedure Sp_mng_rel_rentabilidade_grupo2_bonif
	end
go

print 'Criando Procedure Sp_mng_rel_rentabilidade_grupo2_bonif'
go
					

create PROCEDURE Sp_mng_rel_rentabilidade_grupo2_bonif 

@dte_datainicio AS DATETIME = NULL, 
@dte_datafim AS DATETIME = NULL, 
@idsecao INT 

AS 
DECLARE 
    @dt_inicio_tmp DATETIME, 
    @dt_fim_tmp    DATETIME 


IF @dte_datainicio IS NULL 
    BEGIN 
        SET @dt_inicio_tmp = CONVERT(DATETIME, RIGHT('0000' + CONVERT(NVARCHAR , Year (( Getdate() - 120 ))), 4) + '/'+ RIGHT('00' + CONVERT(NVARCHAR , Month( Getdate() - 120)), 2) + '/01') 
    END 
ELSE 
    BEGIN 
        SET @dt_inicio_tmp = @dte_datainicio 
    END 

IF @dte_datafim IS NULL 
    BEGIN 
        SET @dt_fim_tmp = CONVERT(DATETIME, RIGHT('0000' + CONVERT(NVARCHAR, Year( ( Getdate() - 1 ))), 4) + '/' + RIGHT('00' + CONVERT(NVARCHAR, Month ( Getdate() - 1)), 2) + '/' + RIGHT('00' + CONVERT(NVARCHAR, Day( Getdate () - 1)), 2)) 
    END 
ELSE 
    BEGIN 
        SET @dt_fim_tmp = @dte_datafim 
    END 


INSERT INTO tmp_rel_retab_itens2 (
                int_idsecao, 
                int_idmovimento, 
                int_idempresa, 
                int_idlocalestoque, 
                dte_datamovimento, 
                str_idfuncionario, 
                str_idsupervisor, 
                str_tmk, 
                int_numerodoc, 
                str_codinome, 
                str_nometmk, 
                fk_int_tipomovimento, 
                str_tipomovimento, 
                str_idtipodocumento, 
                int_mes, 
                int_ano, 
                str_rota, 
                str_idgrupo, 
                str_idreferencia, 
                str_iditem, 
                int_idmarca, 
                int_cidade, 
                str_cidade, 
                str_nomecadastro, 
                int_prazomedioparcelas, 
                int_classemovimento, 
                cur_qtde_venda, 
                cur_total_itens, 
                cur_total_substtrib, 
                cur_total_acresc, 
                cur_total_desc, 
                cur_total_nf, 
                cur_custo_venda, 
                cur_rentab_valor, 
                cur_rentab_perc,
                str_estado
               ) 
        SELECT -- venda   
            'Idsecao' = @idsecao, 
            'idmovimento' = a.pk_int_movimento, 
            'idempresa' = a.fk_int_empresa, 
            'idlocalestoque' = a.fk_int_locaisestoque, 
            'DataMovimento' = a.dte_movimento, 
            'idfuncionario' = Representante.str_idfuncionario, 
            'idsupervisor' = Supervisor.str_idfuncionario, 
            'IdTMK' = a.fk_str_tmk, 
            'NumeroDocumento' = a.int_númerodocumento, 
            'Idcadastro' = g.str_codinome, 
            'NomeTMK' = a.str_nometmk, 
            'IdTipoMovimento' = a.fk_int_tipomovimento, 
            'TipoMovimento' = (CASE 
                                    WHEN a.int_classemovimento = 2 
                                        THEN 'Vendas' 
                                    WHEN a.int_classemovimento = 9 
                                        THEN 'Bonificacao' 
                                    WHEN a.int_classemovimento = 8 
                                        THEN 'Devolucao' 
                              END ),--str_TipoMovimento,   
            'TipoDoc' = a.str_idtipodocumento,--str_IdTipoDocumento   
            'Mes' = CONVERT(INT, Month(a.dte_movimento)),--int_Mes   
            'Ano' = CONVERT(INT, Year(a.dte_movimento)),--int_Ano   
            'Rota' = h.str_rota,--str_Rota,   
            'Grupo' = d.pk_int_grupo, 
            'Referencia' = e.pk_int_referencia, 
            'Iditem' = c.str_iditem, 
            'IdMarca' = f.pk_int_marca, 
            'IdCidade' = i.pk_int_cidade, 
            'Cidade' = i.str_cidade, 
            'NomeCadastro' = g.str_nome, 
            'PrazoMedioParcelas' = a.int_prazomedioparcelas, 
            'ClasseMovimento' = a.int_classemovimento, 
            'QuantidadeVenda' = ( b.cur_quantidade ), 
            'totalitem' = ( b.cur_quantidade * b.cur_valorunitario ),     
            'valorSubst' = (CASE 
                                WHEN Isnull(b.cur_valorsubstituicaotributaria, 0) < 0 
                                    THEN 0 
                                ELSE Isnull(b.cur_valorsubstituicaotributaria, 0) 
                           END ),--cur_total_SubstTrib >> VlrSubst   
            'ValorOutrosAcres' = ( b.cur_vlrrateiofrete ), 
            'ValorOutrosDesc' = ( ( b.cur_vlrrateiodesconto ) * -1 ), 
            'TotalNF' = ( b.cur_quantidade * b.cur_valorunitario ) + Isnull(b.cur_vlrrateiooutrasdespesas, 0) + Isnull(b.cur_totalipi, 0) + (CASE 
                                                                                                                                                WHEN Isnull(b.cur_valorsubstituicaotributaria, 0) < 0 
                                                                                                                                                    THEN 0 
                                                                                                                                                ELSE Isnull(b.cur_valorsubstituicaotributaria, 0) 
                                                                                                                                             END ) + ( b.cur_vlrrateiofrete ) + ((b.cur_vlrrateiodesconto ) * -1 ),--cur_total_NF >> TotalNF   
            'CustoVenda' = ( ( b.cur_valorcustounitario * b.cur_quantidade ) * -1 ), --cur_custo_venda >> CustoVenda   
            'RentValor' = ( ( b.cur_quantidade * b.cur_valorunitario ) + Isnull(b.cur_vlrrateiooutrasdespesas, 0) + Isnull(b.cur_totalipi, 0) + (CASE 
                                                                                                                                                    WHEN Isnull(b.cur_valorsubstituicaotributaria, 0 ) < 0 
                                                                                                                                                        THEN 0 
                                                                                                                                                    ELSE Isnull(b.cur_valorsubstituicaotributaria, 0 ) 
                                                                                                                                                END ) + (b.cur_vlrrateiofrete) + ( ( b.cur_vlrrateiodesconto ) * -1 ) ) + Round((( b.cur_valorcustounitario * b.cur_quantidade ) * -1 ), 2), --cur_rentab_valor >> RentabVlr   
            'RentPerc' = (CASE 
                            WHEN Isnull(( ( b.cur_quantidade * b.cur_valorunitario ) + Isnull(b.cur_vlrrateiooutrasdespesas, 0) + Isnull(b.cur_totalipi, 0) + (CASE 
                                                                                                                                                                    WHEN Isnull(b.cur_valorsubstituicaotributaria, 0 ) < 0 
                                                                                                                                                                        THEN 0 
                                                                                                                                                                    ELSE Isnull(b.cur_valorsubstituicaotributaria, 0 ) 
                                                                                                                                                               END ) + (b.cur_vlrrateiofrete) + ( ( b.cur_vlrrateiodesconto ) * -1 ) ), 0) = 0 
                                THEN 0 
                            ELSE ( Isnull(( ( ( b.cur_quantidade * b.cur_valorunitario ) + Isnull(b.cur_vlrrateiooutrasdespesas, 0) + Isnull(b.cur_totalipi, 0) + (CASE 
                                                                                                                                                                     WHEN Isnull(b.cur_valorsubstituicaotributaria, 0) < 0 
                                                                                                                                                                        THEN 0 
                                                                                                                                                                     ELSE Isnull(b.cur_valorsubstituicaotributaria, 0) 
                                                                                                                                                                   END ) + ( b.cur_vlrrateiofrete ) + ( ( b.cur_vlrrateiodesconto ) * -1 ) ) + Round(( ( b.cur_valorcustounitario * b.cur_quantidade ) * -1 ) , 2) ) / ( ( b.cur_quantidade * b.cur_valorunitario ) + Isnull(b.cur_vlrrateiooutrasdespesas, 0) + Isnull(b.cur_totalipi, 0) + (CASE 
                                                                                                                                                                                                                                                                                                                                                                                                                                                 WHEN Isnull(b.cur_valorsubstituicaotributaria, 0) < 0 
                                                                                                                                                                                                                                                                                                                                                                                                                                                    THEN 0 
                                                                                                                                                                                                                                                                                                                                                                                                                                                 ELSE Isnull(b.cur_valorsubstituicaotributaria, 0) 
                                                                                                                                                                                                                                                                                                                                                                                                                                              END ) + ( b.cur_vlrrateiofrete ) + ( ( b.cur_vlrrateiodesconto ) * -1 ) ), 0) * 10 ) 
                          END) ,--cur_rentab_perc >> faz no relatório   
                          i.str_UF
    FROM   
       mvt_saida AS a WITH ( nolock ) 
           INNER JOIN 
       mvt_saida_itens AS b WITH ( nolock ) 
               ON a.pk_int_movimento = b.fk_int_movimento 
           INNER JOIN 
       estoque AS c WITH ( nolock ) 
               ON c.pk_int_estoque = b.fk_int_estoque 
           LEFT JOIN 
        funcionario AS Representante WITH ( nolock ) 
               ON Representante.pk_int_funcionario = a.fk_int_funcionario 
           LEFT JOIN 
        funcionario AS Supervisor WITH (nolock) 
               ON Representante.int_supervisor = Supervisor.pk_int_funcionario 
           INNER JOIN 
        grupo AS d WITH ( nolock ) 
               ON d.pk_int_grupo = c.fk_int_grupo 
           INNER JOIN 
        referencia AS e WITH ( nolock ) 
               ON e.pk_int_referencia = c.fk_int_referencia 
           LEFT JOIN 
        marca AS f WITH ( nolock ) 
               ON f.pk_int_marca = c.fk_int_marca 
           INNER JOIN 
        cadastro AS g WITH ( nolock ) 
               ON g.pk_int_cadastro = a.fk_int_cadastro 
           LEFT JOIN 
        rota AS h WITH ( nolock ) 
                ON Representante.pk_int_funcionario = h.fk_int_funcionario 
           LEFT JOIN 
        cidade i WITH ( nolock ) 
                ON g.fk_int_cidade = i.pk_int_cidade 
    WHERE  
        (a.int_classemovimento = 2 ) 
        AND ( a.dte_movimento >= @dt_inicio_tmp ) 
        AND ( a.dte_movimento <= @dt_fim_tmp ) 

    UNION ALL 

    SELECT -- Bonificação   
        'Idsecao' = @idsecao, 
        'idmovimento' = a.pk_int_movimento, 
        'idempresa' = a.fk_int_empresa, 
        'idlocalestoque' = a.fk_int_locaisestoque, 
        'DataMovimento' = a.dte_movimento, 
        'idfuncionario' = Representante.str_idfuncionario, 
        'idsupervisor' = Supervisor.str_idfuncionario, 
        'IdTMK' = a.fk_str_tmk, 
        'NumeroDocumento' = a.int_númerodocumento, 
        'Idcadastro' = g.str_codinome, 
        'NomeTMK' = a.str_nometmk, 
        'IdTipoMovimento' = a.fk_int_tipomovimento, 
        'TipoMovimento' = ( CASE 
                              WHEN a.int_classemovimento = 2 THEN 'Vendas' 
                              WHEN a.int_classemovimento = 9 THEN 'Bonificacao' 
                              WHEN a.int_classemovimento = 8 THEN 'Devolucao' 
                            END ),--str_TipoMovimento,   
        'TipoDoc' = a.str_idtipodocumento,--str_IdTipoDocumento   
        'Mes' = CONVERT(INT, Month(a.dte_movimento)),--int_Mes   
        'Ano' = CONVERT(INT, Year(a.dte_movimento)),--int_Ano   
        'Rota' = h.str_rota,--str_Rota,   
        'Grupo' = d.pk_int_grupo, 
        'Referencia' = e.pk_int_referencia, 
        'Iditem' = c.str_iditem, 
        'IdMarca' = f.pk_int_marca, 
        'IdCidade' = i.pk_int_cidade, 
        'Cidade' = i.str_cidade, 
        'NomeCadastro' = g.str_nome, 
        'PrazoMedioParcelas' = a.int_prazomedioparcelas, 
        'ClasseMovimento' = a.int_classemovimento, 
        'QuantidadeVenda' = ( b.cur_quantidade ), 
        'totalitem' = ( b.cur_quantidade * b.cur_valorunitario ), 
        --cur_total_itens >> VlrVenda   
        'valorSubst' = ( CASE 
                           WHEN Isnull(b.cur_valorsubstituicaotributaria, 0) < 0 
                         THEN 0 
                           ELSE Isnull(b.cur_valorsubstituicaotributaria, 0) 
                         END ),--cur_total_SubstTrib >> VlrSubst   
        'ValorOutrosAcres' = ( b.cur_vlrrateiofrete ), 
        --cur_total_acresc >> OutrosAcres   
        'ValorOutrosDesc' = ( ( b.cur_vlrrateiodesconto ) * -1 ), 
        --cur_total_desc >> OutrosDesc   
        'TotalNF' = 0,--cur_total_NF >> TotalNF   
        'CustoVenda' = Round(( ( b.cur_valorcustounitario * b.cur_quantidade ) * -1 
                             ), 2 
                       ),--cur_custo_venda >> CustoVenda   
        'RentValor' = Round(( ( b.cur_valorcustounitario * b.cur_quantidade ) * -1 ) 
                      , 2) 
        ,--cur_rentab_valor >> RentabVlr   
        'RentPerc' = 0, --cur_rentab_perc >> faz no relatório   
        i.str_UF
    FROM   
        mvt_saida AS a WITH ( nolock ) 
            INNER JOIN 
        mvt_saida_itens AS b WITH ( nolock ) 
                ON a.pk_int_movimento = b.fk_int_movimento 
           INNER JOIN 
        estoque AS c WITH ( nolock ) 
                ON c.pk_int_estoque = b.fk_int_estoque 
           LEFT JOIN 
        funcionario AS Representante WITH ( nolock ) 
                ON Representante.pk_int_funcionario = a.fk_int_funcionario 
           LEFT JOIN 
        funcionario AS Supervisor WITH ( nolock ) 
                ON Representante.int_supervisor = Supervisor.pk_int_funcionario 
           INNER JOIN 
        grupo AS d WITH ( nolock ) 
                ON d.pk_int_grupo = c.fk_int_grupo 
           INNER JOIN 
        referencia AS e WITH ( nolock ) 
                ON e.pk_int_referencia = c.fk_int_referencia 
           LEFT JOIN 
        marca AS f WITH ( nolock ) 
                ON f.pk_int_marca = c.fk_int_marca 
           INNER JOIN 
        cadastro AS g WITH ( nolock ) 
                ON g.pk_int_cadastro = a.fk_int_cadastro 
           LEFT JOIN 
        rota AS h WITH ( nolock ) 
                ON Representante.pk_int_funcionario = h.fk_int_funcionario 
           LEFT JOIN cidade i WITH ( nolock ) 
                ON g.fk_int_cidade = i.pk_int_cidade 
    WHERE  --(a.fk_int_TipoMovimento in (24, 64, 66)) AND    
      (a.bit_bonificacao = 1) 
      AND ( a.int_classemovimento = 9 ) 
      AND ( a.dte_movimento >= @dt_inicio_tmp ) 
      AND ( a.dte_movimento <= @dt_fim_tmp ) 

    UNION ALL -- Devoluçao   

    SELECT 
        'Idsecao' = @idsecao, 
        'idmovimento' = devolucao.pk_int_movimento, 
        'idempresa' = devolucao.fk_int_empresa, 
        'idlocalestoque' = devolucao.fk_int_locaisestoque, 
        'DataMovimento' = devolucao.dte_movimento, 
        'idfuncionario' = Representante.str_idfuncionario, 
        'idsupervisor' = Supervisor.str_idfuncionario, 
        'IdTMK' = a.fk_str_tmk, 
        'NumeroDocumento' = devolucao.int_númerodocumento, 
        'Idcadastro' = f.str_codinome, 
        'NomeTMK' = a.str_nometmk, 
        'IdTipoMovimento' = devolucao.fk_int_tipomovimento, 
        'TipoMovimento' = (CASE 
                              WHEN devolucao.int_classemovimento = 2 
                                THEN 'Vendas' 
                              WHEN devolucao.int_classemovimento = 9 
                                THEN 'Bonificacao' 
                              WHEN devolucao.int_classemovimento = 8 
                                THEN 'Devolucao' 
                          END ),--str_TipoMovimento,   
        'TipoDoc' = devolucao.str_idtipodocumento,--str_IdTipoDocumento   
        'Mes' = CONVERT(INT, Month(devolucao.dte_movimento)),--int_Mes   
        'Ano' = CONVERT(INT, Year(devolucao.dte_movimento)),--int_Ano   
        'Rota' = j.str_rota,--str_Rota,   
        'Grupo' = g.pk_int_grupo, 
        'Referencia' = h.pk_int_referencia, 
        'Iditem' = d.str_iditem, 
        'IdMarca' = i.pk_int_marca, 
        'IdCidade' = k.pk_int_cidade, 
        'Cidade' = k.str_cidade, 
        'NomeCadastro' = f.str_nome, 
        'PrazoMedioParcelas' = a.int_prazomedioparcelas, 
        'ClasseMovimento' = a.int_classemovimento, 
        'QuantidadeVenda' = ( b.cur_quantidade ) * -1, 
        'totalitem' = ( b.cur_quantidade * b.cur_valorunitario ) * -1, --cur_total_itens >> VlrVenda   
        'valorSubst' = (CASE 
                           WHEN Isnull(b.cur_valorsubstituicaotributaria, 0) < 0 OR Isnull(devolucao.cur_totalicmsubsttrib, 0 ) = 0 
                              THEN 0 
                           ELSE Isnull(b.cur_valorsubstituicaotributaria, 0) 
                       END ) * -1,--cur_total_SubstTrib >> VlrSubst   
        'ValorOutrosAcres' = ( b.cur_vlrrateiofrete ) * -1, --cur_total_acresc >> OutrosAcres   
        'ValorOutrosDesc' = ( b.cur_vlrrateiodesconto ), --cur_total_desc >> OutrosDesc   
        'TotalNF' = ( ( b.cur_quantidade * b.cur_valorunitario ) * -1 ) + ( Isnull(b.cur_vlrrateiooutrasdespesas, 0) * -1 ) + ( Isnull(b.cur_totalipi, 0) * -1 ) + ( ( CASE WHEN Isnull(b.cur_valorsubstituicaotributaria, 0) < 0 OR Isnull(devolucao.cur_totalicmsubsttrib, 0) = 0 THEN 0 ELSE Isnull(b.cur_valorsubstituicaotributaria, 0) END ) * -1 ) + ( ( b.cur_vlrrateiofrete ) * -1 ) + ( b.cur_vlrrateiodesconto ),--cur_total_NF >> TotalNF  
        'CustoVenda' = Round(( b.cur_valorcustounitario * b.cur_quantidade ), 2), --cur_custo_venda >> CustoVenda   
        'RentValor' = ( ( ( b.cur_quantidade * b.cur_valorunitario ) * -1 ) + ( Isnull(b.cur_vlrrateiooutrasdespesas, 0 ) * -1 ) + ( Isnull(b.cur_totalipi, 0) * -1 ) + ( ( CASE WHEN Isnull(b.cur_valorsubstituicaotributaria, 0 ) < 0 THEN 0 ELSE Isnull(b.cur_valorsubstituicaotributaria, 0 ) END ) * -1 ) + ( ( b.cur_vlrrateiofrete ) * -1 ) + ( b.cur_vlrrateiodesconto ) ) + (( b.cur_valorcustounitario * b.cur_quantidade )), --cur_rentab_valor >> RentabVlr   
        'RentPerc' = (CASE 
                        WHEN Isnull((( ( b.cur_quantidade * b.cur_valorunitario ) * -1 ) + ( Isnull(b.cur_vlrrateiooutrasdespesas, 0) * -1 ) + ( Isnull(b.cur_totalipi, 0) * -1 ) + ( ( CASE WHEN Isnull(b.cur_valorsubstituicaotributaria, 0 ) < 0 THEN 0 ELSE Isnull(b.cur_valorsubstituicaotributaria, 0 ) END ) * -1 ) + ( ( b.cur_vlrrateiofrete ) * -1 ) + ( b.cur_vlrrateiodesconto ) ), 0) = 0 
                            THEN 0 
                        ELSE ( Isnull(( ( ( ( b.cur_quantidade * b.cur_valorunitario ) * -1 ) + ( Isnull(b.cur_vlrrateiooutrasdespesas, 0) * -1 ) + ( Isnull (b.cur_totalipi, 0 ) * -1 ) + ( ( CASE WHEN Isnull(b.cur_valorsubstituicaotributaria, 0) < 0 THEN 0  ELSE Isnull(b.cur_valorsubstituicaotributaria, 0) END ) * -1 ) + ( ( b.cur_vlrrateiofrete ) * -1 ) + ( b.cur_vlrrateiodesconto ) ) + ( ( b.cur_valorcustounitario * b.cur_quantidade )) ) / ( ( ( b.cur_quantidade * b.cur_valorunitario ) * -1 ) + ( Isnull(b.cur_vlrrateiooutrasdespesas, 0 ) * -1 ) + ( Isnull(b.cur_totalipi, 0) * -1 ) + ( ( CASE WHEN Isnull(b.cur_valorsubstituicaotributaria, 0 ) < 0 THEN 0 ELSE Isnull(b.cur_valorsubstituicaotributaria, 0 ) END ) * -1 ) + ( ( b.cur_vlrrateiofrete ) * -1 ) + ( b.cur_vlrrateiodesconto ) ), 0) * 10 ) 
                     END ), --cur_rentab_perc >> faz no relatório   
         k.str_UF
    FROM   
        mvt_saida AS a WITH ( nolock ) 
            INNER JOIN 
        mvt_entrada AS devolucao WITH ( nolock ) 
                ON a.pk_int_movimento = devolucao.int_idmovorigem 
            INNER JOIN 
        mvt_entrada_itens AS b WITH ( nolock ) 
                ON devolucao.pk_int_movimento = b.fk_int_movimento 
            INNER JOIN 
        funcionario AS Representante WITH ( nolock ) 
                ON a.fk_int_funcionario = Representante.pk_int_funcionario 
            LEFT OUTER JOIN 
        funcionario AS Supervisor WITH ( nolock ) 
                ON Representante.int_supervisor = Supervisor.pk_int_funcionario 
            INNER JOIN 
        cadastro AS f WITH ( nolock ) 
                ON f.pk_int_cadastro = devolucao.fk_int_cadastro 
            INNER JOIN 
        estoque AS d 
                ON b.fk_int_estoque = d.pk_int_estoque 
            LEFT OUTER JOIN 
        grupo AS g WITH ( nolock ) 
                ON g.pk_int_grupo = d.fk_int_grupo 
            LEFT OUTER JOIN 
        referencia AS h WITH ( nolock ) 
                ON h.pk_int_referencia = d.fk_int_referencia 
            LEFT OUTER JOIN 
        marca AS i WITH ( nolock ) 
                ON i.pk_int_marca = d.fk_int_marca 
            LEFT JOIN 
        rota AS j WITH ( nolock ) 
                ON Representante.pk_int_funcionario = j.fk_int_funcionario 
            LEFT JOIN 
        cidade k WITH ( nolock ) 
                ON f.fk_int_cidade = k.pk_int_cidade 
    WHERE  
        (devolucao.bit_devolucao = 1) 
        AND (devolucao.int_classemovimento = 8 AND Isnull(devolucao.int_idmovorigem, 0) <> 0) 
        AND ( devolucao.dte_movimento >= @dt_inicio_tmp) 
        AND ( devolucao.dte_movimento <= @dt_fim_tmp ) 

go

grant exec on Sp_mng_rel_rentabilidade_grupo2_bonif to public

go