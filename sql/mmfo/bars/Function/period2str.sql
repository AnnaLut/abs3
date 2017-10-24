
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/period2str.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.PERIOD2STR (
  p_date_from in date,
  p_date_to in date) return varchar2
is
  l_month_cnt number;
  l_days_cnt number;
begin
  l_month_cnt := trunc(months_between(trunc(p_date_to), trunc(p_date_from)));
  l_days_cnt := trunc(trunc(p_date_to) - add_months(p_date_from,trunc(months_between (p_date_to, p_date_from),0)));
  return
    case when l_month_cnt > 0 then f_sumpr(l_month_cnt, null, 'M' )||' міс. ' end ||
    case when l_days_cnt > 0 then f_sumpr(l_days_cnt, null,'M') ||' дн. ' end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/period2str.sql =========*** End ***
 PROMPT ===================================================================================== 
 