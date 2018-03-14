declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_reported_object
     (
            id number(38),
            object_type_id number(5),
            state_id number(5),
            external_id varchar2(4000 byte)
     )
     tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/
