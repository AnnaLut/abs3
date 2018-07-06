

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SNA_PD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SNA_PD ***

  CREATE OR REPLACE PROCEDURE BARS.P_SNA_PD (p_dat01 date) IS

/* Версия 1.1 05-07-2018   23-02-2017
   Заполнение PD
   05-07-2018 (1.1) - Добавлены счета ('SNA','SDI','SDA','SDM','SDF','SRR')
   -------------------------------------
*/

l_pd rez_cr.pd%type; l_lgd rez_cr.lgd%type; l_idf rez_cr.idf%type;

begin
   for i in (select r.rowid RI, r.* from rez_cr r  where  r.fdat=p_dat01 and r.tip in ('SNA','SDI','SDA','SDM','SDF','SRR') )
   LOOP
      begin
         select pd, lgd, idf into l_pd, l_lgd, l_idf
         from ( select distinct nd, kv, pd, lgd, idf
                from rez_cr
                where fdat=p_dat01 and nbs<>'9129' and nd = i.nd and kv = i.kv and tip not in ('SNA','SDI','SDA','SDM','SDF','SRR')  and rownum = 1 );
         update rez_cr set pd  = l_pd, lgd = l_lgd, idf = l_idf where rowid=i.RI ;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_pd := NULL; l_lgd := NULL; l_idf := NULL;
      END;
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
