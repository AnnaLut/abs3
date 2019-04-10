begin
    bpa.alter_policy_info('OBJECT_TYPE', 'WHOLE' , null, null, null, null);
    bpa.remove_policies('OBJECT_TYPE');
    bpa.add_policies('OBJECT_TYPE');
end;
/

declare
    column_already_exists exception;
    pragma exception_init(column_already_exists, -1430);
begin
    execute immediate 'alter table object_type add is_active char(1 char) default ''Y'' not null';
exception
    when column_already_exists then
         null;
end;
/

declare
    column_doesnt_exist exception;
    pragma exception_init(column_doesnt_exist, -904);
begin
    execute immediate 'alter table object_type drop column state_id';
exception
    when column_doesnt_exist then
         null;
end;
/