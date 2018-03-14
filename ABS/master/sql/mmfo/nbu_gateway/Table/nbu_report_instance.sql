declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_report_instance
    (
            id number(38),
            reporting_date date,
            stage_id number(5)
    )
    tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/
