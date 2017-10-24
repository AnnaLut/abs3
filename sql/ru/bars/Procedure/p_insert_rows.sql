prompt ------------------------------------------
prompt  создание процедуры INSERT_ROWS
prompt ------------------------------------------
/
CREATE OR REPLACE procedure BARS.insert_rows   (p_rows in FLAT_FILE_LIST) is
begin
  insert into TMP_IMP_FILE
    select * from table(p_rows);
end;
/
grant execute on BARS.insert_rows to bars_access_defrole;
/
