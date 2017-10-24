
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_s250.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_S250 (p_acc INTEGER) RETURN number is

/* Версия 2.0 18-01-2017   29-12-2016
   Определение 9129 к портфельному методу

  1) 18-01-2017 - В новом файле описаны счета к портфельному методу (там нет 9129) Пока отложена
*/



L_TIP  number := 0;


begin
/*
   begin
      select 1 INTO L_TIP from w4_acc where acc_9129 = p_acc and s250=8;
   EXCEPTION  WHEN NO_DATA_FOUND   THEN
      begin
         select 1 INTO L_TIP from bpk_acc where acc_9129 = p_acc and s250=8;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
         begin
            select 1 INTO L_TIP from nd_acc n ,cc_deal c where n.acc=p_acc and n.nd=c.nd and c.s250=8;
         EXCEPTION  WHEN NO_DATA_FOUND THEN l_TIP := 0;
         end;
      end;
   end;
*/
   return l_TIP;
end;
/
 show err;
 
PROMPT *** Create  grants  F_S250 ***
grant EXECUTE                                                                on F_S250          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_S250          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_s250.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 