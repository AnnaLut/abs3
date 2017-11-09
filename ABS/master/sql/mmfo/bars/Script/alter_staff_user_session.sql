declare
    nonexistent_primary_key exception;
    pragma exception_init(nonexistent_primary_key, -2441);
begin
    execute immediate 'alter table staff_user_session drop primary key cascade drop index';
exception
    when nonexistent_primary_key then
         null;
end;
/
