declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    dbms_errlog.create_error_log('DEAL');
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    dbms_errlog.create_error_log('OBJECT');
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    dbms_errlog.create_error_log('DEAL_ACCOUNT');
exception
    when name_already_used then
         null;
end;
/
