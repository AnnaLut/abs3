

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SNA_PD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SNA_PD ***

  CREATE OR REPLACE PROCEDURE BARS.P_SNA_PD (p_dat01 date) IS

/* Версия 1.0 23-02-2017
   Заполнение PD
   -------------------------------------
*/

l_pd number; l_lgd number;

begin
   for i in (select r.rowid RI, r.* from rez_cr r  where  r.fdat=p_dat01 and r.tip in ('SNA','SDI','SPI') )
   LOOP
      begin
         select pd,lgd into l_pd,l_lgd
         from ( select distinct nd,kv,pd,lgd
                from rez_cr
                where fdat=p_dat01 and nbs<>'9129' and bv>0 and nd = i.nd and kv = i.kv and rownum = 1 );
      EXCEPTION WHEN NO_DATA_FOUND THEN l_pd := NULL; l_lgd := NULL;
      END;
      update rez_cr set pd  = l_pd, lgd=l_lgd where rowid=i.RI ;
   END LOOP;
end;
/
show err;

PROMPT *** Create  grants  P_SNA_PD ***
grant EXECUTE                                                                on P_SNA_PD        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_SNA_PD        to RCC_DEAL;
grant EXECUTE                                                                on P_SNA_PD        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SNA_PD.sql =========*** End *** 
PROMPT ===================================================================================== 
