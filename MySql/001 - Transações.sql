/*	Criando Tabela	*/
create table teste2
(	
	codigo int unsigned not null,
    nome varchar(45) not null,
    insercao timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    
/*	Verificando status autocommit	*/
SELECT @@autocommit;
    
/*	alterando autocommit	*/
SET autocommit=0

/*	inserindo um registro	*/
insert INTO teste2 VALUE ( 3, 'registro0', NOW() );

/*	
	abra uma nova instancia do mysql 
    rode o select abaixo
*/
SELECT * FROM teste2;

/*	
	nada aconteceu. rode o camomando abaixo. rode o select novamente que o registro 
    vai estar na tabela teste2
*/
commit;