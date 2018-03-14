declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_core_data_request_tracking
    (
            request_id number(38),
            sys_time date,
            state_id number(5),
            tracking_message varchar2(4000 byte)
    )
    tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/
