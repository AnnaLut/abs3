declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_reported_person
     (
            id number(38),
            person_code varchar2(30 char),
            person_name varchar2(4000 byte),
            core_person_kf varchar2(6 char),
            core_person_id number(38),

            constraint pk_nbu_reported_person primary key (id) using index tablespace brsmdli
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
    execute immediate 'alter table nbu_reported_person add constraint pk_nbu_reported_person primary key (id) using index tablespace brsmdli';
exception
    when name_already_used or table_can_have_only_one_pk then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index uix_nbu_reported_person on nbu_reported_person (person_code) tablespace brsmdli';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_nbu_reported_person_core_id on nbu_reported_person (core_person_kf, core_person_id) tablespace brsmdli compress 1';
exception
    when name_already_used then
         null;
end;
/
