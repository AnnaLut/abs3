

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_TRANS_DAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_TRANS_DAT ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_TRANS_DAT ("ND", "NLS", "KV", "ACC", "NPP", "REF", "FDAT", "SV", "SZ", "SR", "D_PLAN", "D_FAKT", "REFP", "COMM", "RNK") AS 
  select n.nd, a.nls, a.kv, c.acc, c.npp, c.ref, c.fdat, c.sv/100 sv, c.sz/100 sz, c.sv/100-c.sz/100 sr, c.d_plan, c.d_fakt, c.refp, c.comm, a.rnk  from cc_trans_update c, nd_acc n, accounts a
 where c.acc = n.acc and n.acc = a.acc
   and (c.acc, c.npp, c.idupd) in ( select acc, npp, max(idupd) idupd
                                      from cc_trans_update
                                     where fdat <= nvl(to_date(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'), gl.bd)
                                       and nvl(d_fakt, nvl(to_date(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'), gl.bd)) <= nvl(to_date(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'), gl.bd)
                                       and effectdate <= NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd)
                                      group by acc, npp )
   and  (c.chgaction!='D' or (c.chgaction='D' and  nvl(to_date(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'), gl.bd) = c.effectdate ) )
   --and c.npp not in (select npp from cc_trans_update where chgaction = 'D' and f_get_nd_txt(n.ND, 'PR_TR', gl.bd) = 1)
order by c.acc, c.fdat, c.d_plan;

PROMPT *** Create  grants  CC_TRANS_DAT ***
grant SELECT                                                                 on CC_TRANS_DAT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_TRANS_DAT    to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_TRANS_DAT.sql =========*** End *** =
PROMPT ===================================================================================== 
