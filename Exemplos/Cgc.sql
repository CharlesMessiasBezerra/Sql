	'CGC' = ( CASE 
						WHEN tab_cadastro.jurídica = 1
							THEN LEFT(tab_cadastro.cgc, 2) + '.' + LEFT(SUBSTRING(tab_cadastro.CGC, 3, 15),3) + '.'+ LEFT(SUBSTRING(tab_cadastro.CGC, 6, 15), 3) + '/'+ LEFT(SUBSTRING(tab_cadastro.CGC, 9, 15), 4) + '-'+ RIGHT(tab_cadastro.CGC, 2)
	          ELSE LEFT(tab_cadastro.cgc, 3) + '.' + LEFT(SUBSTRING(tab_cadastro.CGC, 4, 14),3) + '.'+ LEFT(SUBSTRING(tab_cadastro.CGC, 7, 14), 3) + '.'+ LEFT(SUBSTRING(tab_cadastro.CGC, 10, 14), 3) + '-'+ RIGHT(tab_cadastro.CGC, 2)
					END ) 