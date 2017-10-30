declare
    index_already_exists exception;
    pragma exception_init(index_already_exists, -955);
begin
    execute immediate 'create unique index bars.ui_attribute_value on bars.attribute_value (attribute_id, object_id) tablespace brsbigi compress 1 local';
exception
    when index_already_exists then
         null;
end;
/

declare
    index_already_exists exception;
    pragma exception_init(index_already_exists, -955);
begin
    execute immediate 'create index bars.i_attribute_number_value on bars.attribute_value (number_value) tablespace brsbigi compress 1 local';
exception
    when index_already_exists then
         null;
end;
/

declare
    index_already_exists exception;
    pragma exception_init(index_already_exists, -955);
begin
    execute immediate 'create index bars.i_attribute_string_value on bars.attribute_value (string_value) tablespace brsbigi compress 1 local';
exception
    when index_already_exists then
         null;
end;
/

declare
    index_already_exists exception;
    pragma exception_init(index_already_exists, -955);
begin
    execute immediate 'create index bars.i_attribute_date_value on bars.attribute_value (date_value) tablespace brsbigi compress 1 local';
exception
    when index_already_exists then
         null;
end;
/
