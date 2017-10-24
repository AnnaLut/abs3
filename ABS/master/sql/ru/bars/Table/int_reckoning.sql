begin
    bars_policy_adm.alter_policy_info('int_reckoning', 'filial', null, null, null, null);
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
    execute immediate 'drop table int_reckoning purge';
exception
    when table_or_view_doesnt_exist then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate '
    create table int_reckoning
    (
        id                      number(38) constraint pk_int_reckoning primary key using index tablespace brsdyni,
        reckoning_id            varchar2(32 char) not null,
        deal_id                 number(38),
        account_id              number(38) not null,
        interest_kind           number(38),
        date_from               date,
        date_to                 date,
        account_rest            number(38),
        interest_rate           number(38, 12),
        interest_amount         number(38),
        interest_tail           number(38, 38),
        purpose                 varchar2(4000 byte),
        state_id                number(5),
        message                 varchar2(4000 byte),
		oper_ref			    number
    )
    tablespace brsdynd';
exception
    when name_already_used then null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create bitmap index i_int_reckoning on int_reckoning (reckoning_id) tablespace brsdyni';
exception
    when name_already_used then null;
end;
/
