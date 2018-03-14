create or replace type t_core_loan_tranche force as object
(
       numdogtr        varchar2(50 char),
       dogdaytr        date,
       enddaytr        date,
       sumzagaltr      number(32),
       r030tr          varchar2(3 char),
       proccredittr    number(5,2),
       periodbasetr    number(1),
       periodproctr    number(1),
       sumarrearstr    number(32),
       arrearbasetr    number(32),
       arrearproctr    number(32),
       daybasetr       number(5),
       dayproctr       number(5),
       factenddaytr    date,
       klasstr         varchar2(1 char),
       risktr          number(32)
);
/
create or replace type t_core_loan_tranches force is table of t_core_loan_tranche;
/
