

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REZ_9100.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REZ_9100 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REZ_9100 ("DAT", "RNK", "ND", "CC_ID", "KV", "NLS", "SDATE", "WDATE", "OBS", "FIN", "KAT", "K", "BV", "PV", "REZ", "ZAL") AS 
  SELECT v.B, a.rnk, a.acc,  a.nbs,  a.kv, a.nls,  a.daos, a.mdate,
       f.obs, f.fin, f.kat,f.k,
       -(rez1.ostc96(a.acc,Dat_last (v.b-4,v.b-1)))/100 S,
       -(rez1.ostc96(a.acc,Dat_last (v.b-4,v.b-1)))/100*(1-f.k),
       (-(rez1.ostc96(a.acc,Dat_last (v.b-4,v.b-1)))/100)*(1-f.k)-((select sum(t.s) from tmp_rez_obesp23 t
        where t.dat = v.B and t.accs=a.acc)/100) REZ,
       (select sum(t.s) from tmp_rez_obesp23 t
        where t.dat = v.B and t.accs=a.acc)/100 ZAL
 from  V_SFDAT v, accounts a, acc_fin_obs_kat f
 where a.nbs ='9100' and a.acc=f.acc(+)
   and rez1.ostc96(a.acc,Dat_last (v.b-4,v.b-1)) <0 ;

PROMPT *** Create  grants  V_REZ_9100 ***
grant SELECT                                                                 on V_REZ_9100      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZ_9100      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REZ_9100.sql =========*** End *** ===
PROMPT ===================================================================================== 
