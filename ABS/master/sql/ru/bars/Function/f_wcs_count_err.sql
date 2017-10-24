
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_wcs_count_err.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_WCS_COUNT_ERR (obj_name varchar2) return number is
  l_cnt number;
begin
  execute immediate 'select count(1) from '||obj_name into l_cnt;
  return l_cnt;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_wcs_count_err.sql =========*** En
 PROMPT ===================================================================================== 
 