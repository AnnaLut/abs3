declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create sequence s_nbu_core_data_request_type';
exception
    when name_already_used then
         null;
end;
/
