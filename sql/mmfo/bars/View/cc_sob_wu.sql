

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_SOB_WU.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_SOB_WU ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_SOB_WU ("PRZ", "ND", "CC_ID", "SDATE", "RNK", "SOS", "FDAT", "ID", "ISP", "TXT", "OTM", "FREQ", "PSYS", "FACT_DATE") AS 
  select "PRZ","ND","CC_ID","SDATE","RNK","SOS","FDAT","ID","ISP","TXT","OTM","FREQ","PSYS","FACT_DATE"
from (
SELECT  1 prz,  d.ND, d.cc_id, d.sdate, d.rnk, d.sos, q.FDAT,   q.ID,     q.ISP,                                q.TXT,       q.OTM, q.FREQ, q.PSYS, q.FACT_DATE
          from cc_sob q, cc_deal d,  V_SFDAT v  where d.nd = q.nd and d.vidd in (1,2,3) and q.fdat >= v.b and q.fdat <= v.e
union all
SELECT  2,  d.ND, d.cc_id, d.sdate, d.rnk, d.sos, o.fdat, o.ref, p.userid,
                Substr(decode(o.dk,1, 'Крд.','Деб.')||a.nls||'/'||a.kv||'='||o.s/100||' '||p.nazn, 1,250)  txt, null, null, null, null
          FROM opldok o, oper p,
             (select ss.fdat, ss.acc from saldoa ss, V_SFDAT v where  ss.fdat >= v.b and ss.fdat <= v.e  ) s,
          nd_acc n,   cc_deal d, accounts a
          WHERE o.FDAT = s.fdat and s.acc= a.acc and o.sos = 5 and o.ref=p.ref and o.acc=a.acc
            and ( a.tip in ('SS ','SL ','SP ', 'SPN') or o.dk=1 and a.tip='SN ')   and a.acc=n.acc
            and n.nd = d.nd and d.vidd in (1,2,3)
union all
SELECT 3,  d.ND, d.cc_id, d.sdate, d.rnk, d.sos, r.bdat, r.id , r.idu, '% ст.'||a.nls||'/'||a.kv||'='||r.ir txt,   null, null, null, null
          FROM (select rr.* from int_ratn rr, V_SFDAT v where rr.bdat >= v.b and rr.bdat <= v.e ) r, nd_acc n, accounts a, cc_deal d
          WHERE r.BDAT >= a.daos  and  r.id=0 and r.acc=a.acc  and a.tip in ('SS ','SL ','SP ') and a.acc=n.acc
            and n.nd = d.nd and d.vidd in (1,2,3)
union all
SELECT 4,  d.ND, d.cc_id, d.sdate, d.rnk, d.sos, d.CHGDATE, d.IDUPD,  d.DONEBY, 'fin='||d.fin23||', obs='||d.obs23||', d.kat='||kat23 txt,  null, null, null, null
          FROM cc_deal_update d, V_SFDAT v  where d.vidd in (1,2,3) and CHGDATE >= v.b and CHGDATE <= v.e
) x;

PROMPT *** Create  grants  CC_SOB_WU ***
grant SELECT                                                                 on CC_SOB_WU       to BARSREADER_ROLE;
grant SELECT                                                                 on CC_SOB_WU       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SOB_WU       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_SOB_WU.sql =========*** End *** ====
PROMPT ===================================================================================== 
