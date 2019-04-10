declare
    duplicate_column_name exception;
    pragma exception_init(duplicate_column_name, -957);
begin
    execute immediate 'alter table attribute_current_date rename column attribute_kind_id to attribute_id';
exception
    when duplicate_column_name then
         null;
end;
/

begin
    execute immediate 'alter table attribute_current_date modify attribute_id number(38)';
end;
/

begin ddl_utl.add_constraint('ALTER TABLE ATTRIBUTE_CURRENT_DATE ADD CONSTRAINT FK_ATTR_CURR_DATE_REF_ATTRIBUT FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE_KIND (ID)'); end;
/
