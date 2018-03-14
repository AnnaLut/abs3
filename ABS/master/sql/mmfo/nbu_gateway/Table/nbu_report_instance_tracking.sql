declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_report_instance_tracking
    (
            report_id number(38),
            sys_time date,
            stage_id number(5),
            tracking_comment varchar2(4000 byte)
    )
    tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/
