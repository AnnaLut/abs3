declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_profit_fo
     (
            request_id   number(38),
            rnk          number(38),
            real6month   number(32),
            noreal6month number(32),
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

comment on table core_profit_fo is 'Дані про дохід Боржника ';
comment on column core_profit_fo.rnk is 'Регистрационный номер.';
comment on column core_profit_fo.real6month is 'Підтверджений дохід Боржника ';
comment on column core_profit_fo.noreal6month is 'Непідтверджений дохід Боржника';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_core_profit_fo on core_profit_fo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
