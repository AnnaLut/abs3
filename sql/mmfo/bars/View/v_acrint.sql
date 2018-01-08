

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACRINT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACRINT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACRINT ("RID", "ISP", "ID", "LCV", "KV_NAME", "LCV_NAME", "NBS", "NLS", "DATF", "DATT", "IR", "BR", "OSTS", "ACRD", "REMI", "OSTA", "ACC", "NMS", "NLSA", "KVA", "NMSA", "NLSB", "KVB", "NMSB", "TT", "NMK", "OKPO", "METR", "DIG", "NAZN", "DIGA", "ACRDR", "OSTSR", "OSTCR", "TYPNACH") AS 
  SELECT   /* ORDERED */ 
         a.rowid,s.isp, a.ID, s.kv,t.LCV,t.NAME, s.nbs, s.nls, a.fdat, a.tdat, a.ir, a.br, nvl(a.osts,0)*power(10,-t.dig),nvl(a.acrd,0)*power(10,-t.dig), 
         a.remi,nvl(s.ostc,0)*power(10,-t.dig), s.acc, s.nms, i1.nls, NVL (i1.kv, s.kv), i1.nms, 
         i2.nls, i2.kv, i2.nms, i.tt, k.nmk, k.okpo, i.metr, t.dig, a.nazn, 
         ta.dig, a.acrd,a.osts,s.ostc, ii.NAME 
    FROM int_accn i, 
         acr_intn a, 
         saldo s, 
         tabval t, 
         accounts i1, 
         accounts i2, 
         tabval ta, 
         cust_acc c, 
         customer k, 
         int_idn ii 
   WHERE i.acc = s.acc 
     AND i.acc = a.acc 
     AND i.ID = a.ID 
     AND i.acc = c.acc 
     AND c.rnk = k.rnk 
     AND i.acra = i1.acc(+) 
     AND i.acrb = i2.acc(+) 
     AND t.kv = s.kv 
     AND i1.kv = ta.kv(+) 
     AND ii.id = a.id(+) 
ORDER BY a.ID, s.kv, SUBSTR (s.nls, 1, 4) || SUBSTR (s.nls, 6), a.fdat 
 ;

PROMPT *** Create  grants  V_ACRINT ***
grant SELECT                                                                 on V_ACRINT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACRINT        to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ACRINT        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACRINT.sql =========*** End *** =====
PROMPT ===================================================================================== 
