create database Banco;

use banco;

create table contas
(
	id int auto_increment not null,
    numero int not null,
    agencia varchar(15),
    saldo float ,
    limite float,
    cpfdono varchar(15),
    primary key (id)
);
select * from contas;

insert into contas (numero ,agencia,saldo,limite,cpfdono )values(1233,'432-x',450,2000,'399.021.543.66');
insert into contas (numero ,agencia,saldo,limite,cpfdono )values(1223,'432-x',440,8000,'399.027.544.66');
insert into contas (numero ,agencia,saldo,limite,cpfdono )values(1253,'432-x',10,1000,'396.0261.543.66');
insert into contas (numero ,agencia,saldo,limite,cpfdono )values(1237,'432-x',47650,6000,'389.021.843.66');

