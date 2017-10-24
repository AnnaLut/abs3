
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cp_pereoc.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CP_PEREOC 
(p_ref IN NUMBER, p_dat IN DATE, p_mode INTEGER) RETURN NUMBER IS

/*
p_mode = 0 - переоценка
       = 1 - алгоритм переоценки
       = 2 - котировка

*/
l_val number;
-- определение переоценки по 23 постанове
begin
   if    p_mode = 0 THEN  -- сумма переоценки
      begin
         select greatest(-pereoc23,0) into l_val from CP_REZERV23 where ref=p_ref and date_report = p_dat;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_val := 0;
      end;
   elsif p_mode = 1 THEN  -- алгоритм переоценки
      begin
         select FL_ALG23 into l_val from CP_REZERV23 where ref=p_ref and date_report = p_dat;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_val := 0;
      end;
   else                   -- котировка
      begin
         select s_rezerv23 into l_val from CP_REZERV23 where ref=p_ref and date_report = p_dat;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_val := 0;
      end;
   end if;
   return l_val;
end f_cp_pereoc;
/
 show err;
 
PROMPT *** Create  grants  F_CP_PEREOC ***
grant EXECUTE                                                                on F_CP_PEREOC     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CP_PEREOC     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cp_pereoc.sql =========*** End **
 PROMPT ===================================================================================== 
 