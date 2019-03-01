declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_credit
     (
            request_id      number(38),
            rnk             number(38),
            nd              number(30),
            ordernum        number(2),
            flagosoba       varchar2(5),
            typecredit      number(2), 
            numdog          varchar2(50),
            dogday          date,
            endday          date,
            sumzagal        number(32),
            r030            varchar2(3),
            proccredit      number(5,2),
            sumpay          number(32),
            periodbase      number(1),
            periodproc      number(1),
            sumarrears      number(32),
            arrearbase      number(32),
            arrearproc      number(32),
            daybase         number(5),
            dayproc         number(5),
            factendday      date,
            flagz           varchar2(5),
            klass           varchar2(2),
            risk            number(32),
            flaginsurance   varchar2(5),
            default_loan_kf varchar2(6 char),
            default_loan_id number(38),
            loan_object_id  number(38),
            status          varchar2(30),
            status_message  varchar2(4000 byte),
            kf              varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


comment on table core_credit is 'Кредитні договори';
comment on column core_credit.rnk is 'Регистрационный номер.';
comment on column core_credit.nd is 'Договір особи';
comment on column core_credit.ordernum is 'Порядковий номер кредитної операції у повідомлені';
comment on column core_credit.flagosoba is 'Ознака особи';
comment on column core_credit.typecredit is 'Вид кредиту/наданого фінансового зобов’язання';
comment on column core_credit.numdog is 'Номер договору';
comment on column core_credit.dogday is 'Дата укладання договору';
comment on column core_credit.endday is 'Кінцева дата погашення кредиту/наданого фінансового зобов’язання';
comment on column core_credit.sumzagal is 'Загальна сума (ліміт кредитної лінії/овердрафту) наданого фінансового зобов’язання';
comment on column core_credit.r030 is 'Код валюти';
comment on column core_credit.proccredit is 'Номінальна процентна ставка';
comment on column core_credit.sumpay is 'Сума платежів за кредитною операцією';
comment on column core_credit.periodbase is 'Періодичність сплати основного боргу';
comment on column core_credit.periodproc is 'Періодичність сплати відсотків';
comment on column core_credit.sumarrears is 'Залишок заборгованості за кредитною операцією';
comment on column core_credit.arrearbase is 'Прострочена заборгованість за основним боргом';
comment on column core_credit.arrearproc is 'Прострочена заборгованість  за процентами';
comment on column core_credit.daybase is 'Кількість днів прострочення за основним боргом';
comment on column core_credit.dayproc is 'Кількість днів прострочення  за процентами';
comment on column core_credit.factendday is 'Дата фактичного погашення кредиту';
comment on column core_credit.flagz is 'Наявність здійснених заходів із примусового стягнення боргу';
comment on column core_credit.klass is 'Клас боржника';
comment on column core_credit.risk is 'Величина кредитного ризику';
comment on column core_credit.flaginsurance is 'Факт страхування  кредиту';
comment on column core_credit.status is 'Статус';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index i_core_credit on core_credit (request_id, nd) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index I_CREDIT_ND on core_credit(nd) tablespace BRSMDLI ';
exception
    when name_already_used then
         null;
end;
/
