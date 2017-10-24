

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INSERT_ROWS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INSERT_ROWS ***

  CREATE OR REPLACE PROCEDURE BARS.INSERT_ROWS (p_rows in FLAT_FILE_LIST) is
begin
  insert into TMP_IMP_FILE
    select * from table(p_rows);
end;
/
show err;

PROMPT *** Create  grants  INSERT_ROWS ***
grant EXECUTE                                                                on INSERT_ROWS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INSERT_ROWS.sql =========*** End *
PROMPT ===================================================================================== 
