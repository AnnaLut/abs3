

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V1_CP_REP_DOX.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V1_CP_REP_DOX ***

  CREATE OR REPLACE FORCE VIEW BARS.V1_CP_REP_DOX ("DAT_UG", "CP_ID", "KV", "NBS", "NMS", "DATP", "KOL", "CENA_KUP", "D31", "REF", "ID", "SR", "SD", "SRQ", "SDQ") AS 
  select DAT_UG,CP_ID,KV,NBS,NMS,DATP,KOL,cena_kup,D31,ref,ID,SR,SD, gl.p_icurval(kv,SR*100,D31)/100 SRQ,  gl.p_icurval(kv,SD*100,D31)/100 SDQ
from (select x.DAT_UG, x.CP_ID, x.KV, aa.NBS, aa.NMS, x.DATP,  x.KOL, x.cena_kup, x.D31, x.ref , x.ID,  round( x.KUPON, 2 ) SR,
            round(  (select SUM((SS1+SN2)/power(1+x.ERR,(FDAT-x.D01)/365)-(SS1+SN2)/power(1+x.IRR,(FDAT-x.D01)/365))*100 from cp_many where ref=x.REF and fdat>=D01)
                  - (select SUM((SS1+SN2)/power(1+x.ERR,(FDAT-x.D31)/365)-(SS1+SN2)/power(1+x.IRR,(FDAT-x.D31)/365))*100 from cp_many where ref=x.REF and fdat>=D31)
                          , 2 ) SD
      from (select e.dat_ug, e.ref, k.id, a.accc, k.cp_id, k.kv, k.datp, k.cena_kup, e.erat/100 IRR, e.erate/100 ERR, f.d01, f.d31,
                 - div0(a.ostc/100, k.cena) KOL,
                 - SUM ( div0( fost(a.acc,f.DAT)/100, k.cena) * greatest( 0,  ( cp.KUPON1(k.id,f.DAT) - cp.KUPON1(k.id,f.DAT-1) )  )  ) /100 kupon
            from cp_deal e, cp_kod k, accounts a,
                 (select c.NUM, trunc(v.B,'MM') D01, (trunc(v.B,'MM') + c.num -1) DAT,  last_day(v.B) D31
                  from conductor c , V_SFDAT v
                  where trunc(v.B,'MM') + c.num -1 >= trunc(v.B,'MM') and trunc(v.B,'MM') + c.num -1 <= last_day(v.B )  and c.num <= 31
                 ) F
            WHERE k.ID = e.ID  and k.tip= 1 and e.acc=a.acc and k.dox > 1 and fost(a.acc,f.DAT) <> 0
--and e.REF = :REF
--and k.id = 395
            group by e.dat_ug, e.ref, k.id, a.accc, k.cp_id, k.kv, k.datp, k.cena_kup, e.erat, e.erate, f.d01,  f.d31,  a.ostc, k.cena
           ) x, accounts aa
      where x.accc = aa.acc
) ;

PROMPT *** Create  grants  V1_CP_REP_DOX ***
grant SELECT                                                                 on V1_CP_REP_DOX   to BARSREADER_ROLE;
grant SELECT                                                                 on V1_CP_REP_DOX   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V1_CP_REP_DOX   to START1;
grant SELECT                                                                 on V1_CP_REP_DOX   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V1_CP_REP_DOX.sql =========*** End *** 
PROMPT ===================================================================================== 
