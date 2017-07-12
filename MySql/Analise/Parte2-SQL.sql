DELIMITER $$
DROP PROCEDURE IF EXISTS gera $$
CREATE PROCEDURE gera (IN linhas INT, IN minDDD INT, IN maxDDD INT, 
	IN minFONE INT, IN maxFONE INT) 
BEGIN
	DECLARE ddd, numero INT;
	REPEAT
		SELECT (FLOOR(minDDD + RAND()*(maxDDD-minDDD))) INTO ddd;
		SELECT concat(
					(FLOOR(minFONE + RAND()*(maxFONE-minFONE))), 
					(FLOOR(minFONE + RAND()*(maxFONE-minFONE)))
			   ) INTO numero;
		INSERT INTO fone VALUES (null, ddd, numero);
		INSERT INTO fone_indexado VALUES (null, ddd, numero);
		SET linhas = linhas - 1;
	UNTIL linhas = 0
	END REPEAT;

END $$

DELIMITER ;
CALL gera(10000, 100, 999, 1000, 9999);