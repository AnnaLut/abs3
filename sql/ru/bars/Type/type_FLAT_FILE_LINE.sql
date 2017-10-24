prompt -------------------------------------
prompt  создание типа FLAT_FILE_LINE
prompt -------------------------------------
/
begin
 execute immediate 'create type bars.flat_file_line as object
(
   id number,
   line varchar2 (4000)
)';
exception when others then if (sqlcode = -955) then null; else raise; end if;    
end;    
/

