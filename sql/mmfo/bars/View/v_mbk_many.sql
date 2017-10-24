

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBK_MANY.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBK_MANY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBK_MANY ("IR", "ID", "DAT", "BRANCH", "NLS", "RNK", "ND", "KV", "VIDD", "SDATE", "WDATE", "S", "IRR0", "OBS", "FIN", "KAT", "K", "BV", "PV", "REZ", "ZAL") AS 
  SELECT null, null, TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') ,  e.branch, to_char(e.vidd),
      e.rnk, e.nd, b.kv, e.vidd, e.sdate, e.wdate, e.LIMIT, e.IR, e.obs23, e.fin23, e.kat23, e.k23, b.BV,
            (  CASE WHEN p.PV is null THEN b.BV*(1-e.k23)  ELSE p.PV       END                     )  PV,
    greatest( (CASE WHEN p.PV is null THEN b.BV*e.k23      ELSE b.BV-p.PV  END) - nvl(z.ZAL,0) , 0 )  REZ,
    nvl(z.ZAL,0)                                                                                      ZAL
FROM cc_deal   E,      v_mbk_BV  B,     v_mbk_PV  P,     v_zal23   Z
where e.vidd  > 1500 AND e.vidd < 1600
  and e.sdate < TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy')
  and ( e.sos > 9 and e.sos < 15 or
        e.wdate >= TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy')
      )
  and e.nd= b.nd and e.nd = p.nd(+) and e.nd = z.nd(+)
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBK_MANY.sql =========*** End *** ===
PROMPT ===================================================================================== 
