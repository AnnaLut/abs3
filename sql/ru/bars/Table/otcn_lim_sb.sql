declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table otcn_lim_sb
     (
       acc  number not null,
       fdat date not null,
       lim  number,
       kf   varchar2(6) default sys_context(''bars_context'',''user_mfo'') not null
     )
     tablespace brssmld';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    table_can_have_only_one_pk exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(table_can_have_only_one_pk, -2260);
begin
    execute immediate 'alter table otcn_lim_sb add constraint pk_otcn_lim_sb primary key (acc, fdat) using index tablespace brssmli';
exception
    when name_already_used then
         null;
    when table_can_have_only_one_pk then
         null;
end;
/
grant select, insert, update, delete on otcn_lim_sb to bars_access_defrole;
grant select, insert, update, delete on otcn_lim_sb to start1;
