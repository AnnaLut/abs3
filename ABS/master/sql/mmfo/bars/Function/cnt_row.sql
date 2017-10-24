
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cnt_row.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CNT_ROW (p_tabl VARCHAR2)
   RETURN NUMBER
AS
   l_cnt   INT;
BEGIN
  begin
    EXECUTE IMMEDIATE 'select count(*) from ' || p_tabl INTO l_cnt;
  exception when others then
    null;
  end;
  RETURN l_cnt;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cnt_row.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 