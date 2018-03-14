declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_core_data_request
    (
            id number(38) not null,
            data_type_id number(38) not null,
            kf varchar2(6 char) not null,
            reporting_date date not null,
            reporting_person varchar2(4000 byte),
            reporting_time date,
            report_id number(38),
            state_id integer not null
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
    execute immediate 'alter table nbu_core_data_request add constraint pk_nbu_core_data_request primary key (id) using index tablespace brsmdli';
exception
    when name_already_used or table_can_have_only_one_pk then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index uix_nbu_core_data_request on nbu_core_data_request (data_type_id, kf, reporting_date) compress 2 tablespace brsmdli';
exception
    when name_already_used then
         null;
end;
/
