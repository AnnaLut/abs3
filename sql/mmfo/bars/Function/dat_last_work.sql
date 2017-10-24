
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dat_last_work.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DAT_LAST_WORK (p_dat DATE)
RETURN DATE IS
-- Последний рабочий день месяца 17-05-2016
k number;  dlw date;
f number;

begin
   select last_day(p_dat) into dlw from dual;
   k := 1;
   while k <10
   LOOP
      begin
         select 1 into f from holiday where holiday = dlw and kv=980;
         dlw:= dlw - 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN exit;
      end;
      k := k + 1;
   end LOOP;
   return dlw;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dat_last_work.sql =========*** End 
 PROMPT ===================================================================================== 
 