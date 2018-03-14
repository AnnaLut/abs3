declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_credit_pledge
     (
            request_id  number(38),
            rnk         number(38),
            nd          number(38),
            acc         number(38),
            sumpledge   number(32),
            pricepledge number(32),
            kf          varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_credit_pledge is 'Забезпечення за кредитним договором';
comment on column core_credit_pledge.rnk is 'Регистрационный номер.';
comment on column core_credit_pledge.nd is 'Договір особи';
comment on column core_credit_pledge.sumpledge is 'Сума забезпечення згідно з договором';
comment on column core_credit_pledge.pricepledge is 'Вартість забезпечення згідно з висновком суб’єкта оціночної діяльності';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_core_credit_pledge on core_credit_pledge (request_id, nd) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
