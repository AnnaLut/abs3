prompt -------------------------------------
prompt  создание типа FLAT_FILE_LIST
prompt -------------------------------------
/
begin 
 execute immediate 'create or replace type flat_file_list is table of flat_file_line';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/
GRANT EXECUTE ON FLAT_FILE_LIST TO BARS_ACCESS_DEFROLE;
/

