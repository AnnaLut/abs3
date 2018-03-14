declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_reported_company
     (
            id number(38) not null,
            company_code varchar2(30 char) not null,
            company_name varchar2(4000 byte),
            core_company_kf varchar2(6 char),
            core_company_id number(38),

            constraint pk_nbu_reported_company primary key (id) using index tablespace brsmdli
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
    execute immediate 'alter table nbu_reported_company add constraint pk_nbu_reported_company primary key (id) using index tablespace brsmdli';
exception
    when name_already_used or table_can_have_only_one_pk then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index uix_nbu_reported_company on nbu_reported_company (company_code) tablespace brsmdli';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_reported_company_core_id on nbu_reported_company (core_company_kf, core_company_id) tablespace brsmdli compress 1';
exception
    when name_already_used then
         null;
end;
/
