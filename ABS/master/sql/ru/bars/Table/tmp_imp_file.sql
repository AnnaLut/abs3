prompt ----------------------------------------
prompt  создание временной таблицы TMP_IMP_FILE 
prompt ----------------------------------------
/
begin 
  execute immediate '
CREATE GLOBAL TEMPORARY TABLE TMP_IMP_FILE
( id number,
  LINE  VARCHAR2(4000 BYTE)
)
ON COMMIT DELETE ROWS';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
grant select, insert, update, delete on TMP_IMP_FILE to bars_access_defrole;
/
