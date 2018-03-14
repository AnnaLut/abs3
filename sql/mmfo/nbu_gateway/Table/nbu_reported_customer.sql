declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_reported_customer
     (
            id number(38) not null,
            customer_code varchar2(30 char) not null,
            customer_name varchar2(4000 byte),
            core_customer_kf varchar2(6 char),
            core_customer_id number(38),

            constraint pk_nbu_reported_customer primary key (id) using index tablespace brsmdli
     )
     tablespace brsmdld';
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
    execute immediate 'alter table nbu_reported_customer add constraint pk_nbu_reported_customer primary key (id) using index tablespace brsmdli';
exception
    when name_already_used or table_can_have_only_one_pk then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index uix_nbu_reported_customer on nbu_reported_customer (customer_code) tablespace brsmdli';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_reported_customer_core_id on nbu_reported_customer (core_customer_kf, core_customer_id) tablespace brsmdli compress 1';
exception
    when name_already_used then
         null;
end;
/
