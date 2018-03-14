declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_gateway.nbu_core_branch
     (
            kf varchar2(6 char) not null,
            branch_name varchar2(4000 byte) not null,
            is_internal number(1) not null,
            service_base_url varchar2(4000 byte),
            service_auth varchar2(4000 byte),
            region_code varchar2(2 char),
            is_active number(1)
     ) tablespace brssmld';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    column_list_already_indexed exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(column_list_already_indexed, -1408);
begin
    execute immediate 'create unique index nbu_gateway.uix_nbu_core_branch on nbu_core_branch (kf) tablespace brssmli';
exception
    when name_already_used or column_list_already_indexed then
         null;
end;
/
