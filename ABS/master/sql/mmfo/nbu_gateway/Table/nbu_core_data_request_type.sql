declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_core_data_request_type
    (
            id number(38),
            data_type_code varchar2(30 char),
            data_type_name varchar2(4000 byte),
            gathering_block varchar2(4000 byte),
            transfering_block varchar2(4000 byte),
            is_active number(1)
    )
    tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/
