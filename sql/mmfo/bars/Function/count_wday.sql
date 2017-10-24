
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/count_wday.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.COUNT_WDAY (p_datb date,p_date date) return number is
l_kol number;
-- количество банк дней в заданном периоде дат p_datb,p_date
-- для переоценки спот сделок модуля Форекс
BEGIN
 BEGIN
 select count(*) into l_kol from fdat where fdat>=p_datb and fdat<=p_date;
 EXCEPTION WHEN NO_DATA_FOUND THEN l_kol:=0;
 END;
RETURN l_kol;
END count_wday;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/count_wday.sql =========*** End ***
 PROMPT ===================================================================================== 
 