
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_mmfo.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_MMFO RETURN boolean is
-- Определение схема MMFO ?

/* Версия 1.0 12-06-2017
 */

mmfo    boolean;
l_mmfo  number ;
begin
   begin
      select count(*) into l_MMFO from mv_kf;
      mmfo := case when ( l_mmfo > 1 ) then true else false end;
   EXCEPTION WHEN NO_DATA_FOUND THEN mmfo := false;   -- схема не MMFO
   end ;
   mmfo := case when ( l_mmfo > 1 ) then true else false end;
   return mmfo;
end;
/
 show err;
 
PROMPT *** Create  grants  F_MMFO ***
grant EXECUTE                                                                on F_MMFO          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_MMFO          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_mmfo.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 