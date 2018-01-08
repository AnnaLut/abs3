
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pd.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PD (p_dat01 date   , p_rnk integer , p_nd  integer, p_custtype integer,
                                      p_kv    integer, p_nbs varchar2, p_fin integer, p_mode integer) RETURN NUMBER is

/* Версия 2.0  22-06-2017   27-01-2017
   Розрахунок  PD по NLO.

   1) 22-06-2017 - По Дебиторке (ХОЗ или ФИН)

   P_MODE = 0 -  PD
          = 1 -  TIP_FIN (0 -> 1-2, 1 -> 1-5, 2 -> 1-10)

*/

 l_pd number; l_idf integer; l_deb integer; l_tip_fin integer;

begin
   if p_nbs like '21%'  THEN l_idf := 70; l_tip_fin := 1;
   elsif p_custtype = 2 THEN l_idf := 50; l_tip_fin := 2;
   elsif p_kv =980      THEN l_idf := 42; l_tip_fin := 1;
   else                      l_idf := 45; l_tip_fin := 1;
   end if;

   begin
      select nvl(deb,0) into l_deb from rez_deb where nbs = p_nbs;
   exception when NO_DATA_FOUND THEN l_deb := 0;
   end;

   if l_deb in (1,2) THEN l_pd := f_rez_kol_fin_pd(l_deb, 2, 0); l_tip_fin := 0;
   else                   l_pd := fin_nbu.get_pd(p_rnk, p_nd, p_dat01, p_fin, NULL, l_idf);
   end if;
   if l_pd is null THEN l_pd:=0; end if;
   if p_mode = 0 THEN  return l_pd;
   else                return l_tip_fin;
   end if;
end;
/
 show err;
 
PROMPT *** Create  grants  F_PD ***
grant EXECUTE                                                                on F_PD            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_PD            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pd.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 