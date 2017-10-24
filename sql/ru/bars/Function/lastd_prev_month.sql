
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/lastd_prev_month.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.LASTD_PREV_MONTH (p_dat date) RETURN date IS
l_dat date;
--
--
-- вычисл€ем последний банковский день предыдущего мес€ца
--
BEGIN
 BEGIN
SELECT max(fdat)
  INTO l_dat
    FROM fdat
    WHERE
    to_number(to_char(fdat,'MM'))=
       decode(to_char(p_dat,'MM'),'01',12,
                 to_number(to_char(p_dat,'MM')-1));
    EXCEPTION WHEN NO_DATA_FOUND THEN l_dat:=p_dat;
 END;
RETURN l_dat;
END lastd_prev_month;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/lastd_prev_month.sql =========*** E
 PROMPT ===================================================================================== 
 