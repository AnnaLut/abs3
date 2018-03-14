declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_session_tracking
     (
            id number(38),
            session_id number(38),
            state_id number(5),
            sys_time date,
            tracking_comment varchar2(4000 byte),
            auxiliary_info clob
     )
     tablespace brsmdld
     lob(auxiliary_info) store as securefile
     (
           deduplicate
           compress high
     )
     partition by range(sys_time) interval (numtoyminterval(1, ''MONTH''))
     (
           partition initial_partition values less than (date ''2018-01-01'')
     )';
exception
    when name_already_used then
         null;
end;
/
