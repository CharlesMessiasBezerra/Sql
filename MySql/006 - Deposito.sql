use banco;

DELIMITER $$
drop procedure if exists Deposito $$
create procedure Deposito(in idp int,in valor float)
begin 
	
    declare  SaldoAnterio float;
    
	select Saldo into SaldoAnterio from contas where contas.id = idp;
	update contas set Saldo = Saldo + valor  where contas.id = idp;
    
    
    select SaldoAnterio,Saldo from contas where contas.id = idp;
    

end $$
DELIMITER ;

call Deposito(1 , 10);