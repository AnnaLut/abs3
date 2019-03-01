declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_session
     (
            id number(38) not null,
            report_id number(38) not null,
            object_id number(38) not null,
            session_type_id number(5) not null,
            request_type varchar2(6 char),
            request_url varchar2(4000 byte),
            request_body clob,
            response_body clob,
            state_id number(5) not null,
            failures_count number(2),
            created_at date,
            last_activity_at date
     )
     tablespace brsmdld
     lob(request_body, response_body) store as securefile
     (
           deduplicate
     )
     enable row movement
     partition by range (state_id) interval (1)
     (
           partition initial_partition values less than (1)
     )';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_nbu_session_object_id on nbu_session (object_id) tablespace brsmdli';
exception
    when name_already_used then
         null;
end;
/


declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index Idx_NBU_SESSION_LAST_ACT on nbu_session (last_activity_at , id) tablespace brsmdli';
exception
    when name_already_used then
         null;
end;
/
declare
begin
    execute immediate 'alter table NBU_GATEWAY.NBU_SESSION add constraint PK_NBU_SESSION primary key (ID) using index  tablespace BRSMDLI';
exception
    when others then null;
end;
/