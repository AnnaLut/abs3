
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_kpz.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_KPZ (p_nd integer, p_dat01 date) RETURN varchar2 is

/* Версия 1.0 06-09-2016
   Визначення зваженного коеф. покриття боргу забезпеченням по ND на дату
   -------------------------------------
    1 (Високий) - KPZ >= 1.3
    2 (Добрий)  - KPZ >= 1
    3 (Низький) - KPZ <  1, або забезпечення відсутнє

*/

 l_kpz   number;  l_dat   date; l_dat31  date; fl_  integer;

begin
   l_dat   := TRUNC(p_dat01, 'MM');
   l_dat31 := Dat_last_work ( l_dat - 1 ) ;
   begin
      select kpz into l_kpz from tmp_rez_obesp23 where dat = l_dat and nd = p_nd and rownum=1;
   exception when NO_DATA_FOUND THEN
      begin
         select 1 into fl_ from rez_protocol where dat= l_dat31 and crc='1' and rownum=1;
         l_kpz := 0;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         l_dat :=TRUNC(l_dat-1, 'MM');
         begin
            select kpz into l_kpz from tmp_rez_obesp23 where dat = l_dat and nd = p_nd and rownum=1;
         exception when NO_DATA_FOUND THEN l_kpz := 0;
         end;
      end;
   end;
   return l_kpz;
end;
/
 show err;
 
PROMPT *** Create  grants  F_KPZ ***
grant EXECUTE                                                                on F_KPZ           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_KPZ           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_kpz.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 