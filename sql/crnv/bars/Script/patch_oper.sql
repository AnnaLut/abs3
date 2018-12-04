declare
  l_length number;
begin
  select DATA_LENGTH
    into l_length
    from ALL_TAB_COLUMNS
   where TABLE_NAME  = 'OPER'
     and OWNER       = 'BARS'
     and COLUMN_NAME = 'ID_O';
  if l_length = 6 
  then 
    execute immediate 'alter table OPER modify ID_O varchar2(8)';
    dbms_output.put_line('Table altered.');
  end if;
exception
  when others then if sqlcode = -2443 then null; else raise; end if;
end;
/