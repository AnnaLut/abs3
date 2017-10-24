

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TRUNCATE_TMP_TABLE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TRUNCATE_TMP_TABLE ***

  CREATE OR REPLACE PROCEDURE BARS.TRUNCATE_TMP_TABLE (p_tabname varchar2) is
begin
 execute immediate 'truncate table '||'tmp_'||substr(p_tabname,5);
end;
/
show err;

PROMPT *** Create  grants  TRUNCATE_TMP_TABLE ***
grant EXECUTE                                                                on TRUNCATE_TMP_TABLE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TRUNCATE_TMP_TABLE.sql =========**
PROMPT ===================================================================================== 
