
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_date_3570.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_DATE_3570 (DAT DATE)  RETURN DATE
IS

/* Версия 04-09-2015 */

d1   number;
d_p  date  ;
mm_  number;
begin
   SELECT EXTRACT(day FROM dat) into d1 FROM dual;
   if d1>=25 THEN
      mm_ := 1;
   ELSE
      MM_ :=0;
   END IF;
   SELECT NP_BDATE (trunc(add_months(dat,mm_) ,'MONTH')+23, 1) into d_p FROM dual;
   return(d_p);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_date_3570.sql =========*** En
 PROMPT ===================================================================================== 
 