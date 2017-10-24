

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LAST_DPPSP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LAST_DPPSP ***

  CREATE OR REPLACE PROCEDURE BARS.P_LAST_DPPSP (p_dat date, p_mod number)
-- ============================================================================
--                    ѕроцедура дл€ вс€кого разного по  ѕ на конец дн€
--    ”станавливает дату полного вынесени€ на просрочку в допю параметры кредита
--
-- ============================================================================
/*
 p_dat  -- дата
 p_mod  -- режим:
 	   p_mod = 1 - проставление даты окончательного выноса на просрочку дл€ договоров, которые перенеслись в эту дату

*/
is
  g_mfo  varchar2(6);
begin
  select getglobaloption('GLB-MFO') into g_mfo from dual;
  if p_mod = 1 then
   begin
    bc.subst_mfo(g_mfo);
    for k in (select na1.nd ND, 'DPPSP' TAG, min(s1.fdat) TXT, a1.kf KF
                from accounts a1, nd_acc na1,  accounts a2, nd_acc na2, saldoa s1, saldoa s2
               where na1.nd = NA2.ND --and na1.nd = 16721
                 and s1.acc = a1.acc and s1.fdat >= a1.daos
                 and na1.acc = a1.acc and a1.tip = 'SS ' and a1.dazs is null
                 and s1.ostf-s1.dos+s1.kos = 0
                 and s2.acc = a2.acc and s2.fdat >= a2.daos
                 and na2.acc = a2.acc and a2.tip in ('SP ','SL ') and a2.dazs is null
                 and s2.ostf-s2.dos+s2.kos <> 0
                 and s1.fdat = s2.fdat
                 and s1.fdat = gl.bd
               group by na1.nd, a1.kf)
      loop
        begin
          insert into  nd_txt  (   nd,   tag,   txt,   kf)
	                values ( k.nd, k.tag, to_char(k.txt,'dd/mm/yyyy'), k.kf);
        exception when dup_val_on_index then
          update nd_txt set txt = to_char(k.txt,'dd/mm/yyyy') where nd=k.nd and tag=k.tag ;
        end;
      end loop;

    bc.set_context;
   end;
  end if;
end p_last_dppsp;
/
show err;

PROMPT *** Create  grants  P_LAST_DPPSP ***
grant EXECUTE                                                                on P_LAST_DPPSP    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_LAST_DPPSP    to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LAST_DPPSP.sql =========*** End 
PROMPT ===================================================================================== 
