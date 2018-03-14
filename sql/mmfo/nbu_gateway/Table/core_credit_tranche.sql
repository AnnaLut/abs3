declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_credit_tranche
     (
            request_id   number(38),
            rnk          number(38),
            nd           number(30),
            numdogtr     varchar2(50),
            dogdaytr     date,
            enddaytr     date,
            sumzagaltr   number(32),
            r030tr       varchar2(3),
            proccredittr number(5,2),
            periodbasetr number(1),
            periodproctr number(1),
            sumarrearstr number(32),
            arrearbasetr number(32),
            arrearproctr number(32),
            daybasetr    number(5),
            dayproctr    number(5),
            factenddaytr date,
            klasstr      varchar2(1),
            risktr       number(32),
            kf           varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_credit_tranche is 'Транші за кредитним договором';
comment on column core_credit_tranche.rnk is 'Регистрационный номер.';
comment on column core_credit_tranche.nd is 'Договір особи';
comment on column core_credit_tranche.numdogtr is 'Номер договору траншу';
comment on column core_credit_tranche.dogdaytr is 'Дата укладання договору траншу';
comment on column core_credit_tranche.enddaytr is 'Кінцева дата погашення заборгованості траншу';
comment on column core_credit_tranche.sumzagaltr is 'Сума наданого фінансового зобов’язання за траншем';
comment on column core_credit_tranche.r030tr is 'Код валюти за траншем';
comment on column core_credit_tranche.proccredittr is 'Процентна ставка за траншем';
comment on column core_credit_tranche.periodbasetr is 'Періодичність сплати основного боргу за траншем';
comment on column core_credit_tranche.periodproctr is 'Періодичність сплати процентів за траншем';
comment on column core_credit_tranche.sumarrearstr is 'Залишок заборгованості за траншем';
comment on column core_credit_tranche.arrearbasetr is 'Прострочена заборгованість за траншем';
comment on column core_credit_tranche.arrearproctr is 'Прострочена заборгованість  за процентами траншу';
comment on column core_credit_tranche.daybasetr is 'Кількість днів прострочення за траншем ';
comment on column core_credit_tranche.dayproctr is 'Кількість днів прострочення за процентами траншу';
comment on column core_credit_tranche.factenddaytr is 'Дата фактичного погашення траншу';
comment on column core_credit_tranche.klasstr is 'Клас боржника за траншем';
comment on column core_credit_tranche.risktr is 'Величина кредитного ризику за траншем';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
   execute immediate 'create index i_core_credit_tranche on core_credit_tranche (request_id, nd) tablespace brsmdli local compress 2';
exception
    when name_already_used then
         null;
end;
/
