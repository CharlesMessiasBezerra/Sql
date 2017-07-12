
use banco;

DELIMITER $$
drop procedure if exists getSaldo $$
create procedure getSaldo(in idp int)
begin 

	select saldo from contas where contas.id = idp;

end $$
DELIMITER ;


call getSaldo(1);