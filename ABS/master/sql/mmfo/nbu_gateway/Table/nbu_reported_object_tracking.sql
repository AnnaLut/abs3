declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_reported_object_tracking
     (
            reported_object_id number(38),
            sys_time date,
            state_id number(5),
            tracking_comment varchar2(4000 byte)
     )
     tablespace brsmdld
     partition by range(sys_time) interval (numtoyminterval(1, ''YEAR''))
     (
           partition initial_partition values less than (date ''2019-01-01'')
     )';
exception
    when name_already_used then
         null;
end;
/
