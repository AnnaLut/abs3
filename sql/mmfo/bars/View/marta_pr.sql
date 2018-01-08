

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MARTA_PR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view MARTA_PR ***

  CREATE OR REPLACE FORCE VIEW BARS.MARTA_PR ("N3901", "KV3901", "NM3901", "N3905", "KV3905", "NM3905", "N7", "NI", "KVI", "NMI", "NAZNI") AS 
  select a.nls,a.kv,substr(a.nms,1,40)||' ',
b.nls,b.kv,substr(b.nms,1,40)||' ',
c.nls,
i.nlsb,i.kvb,i.namb,
substr(i.nazn,1,40)||' ' from
accounts a,accounts b,accounts c,int_accn i
where i.acc=a.acc and i.acra=b.acc  and a.nbs='3901' and i.acrb=c.acc and b.nbs='3905'
order by substr(a.nls,7,3);

PROMPT *** Create  grants  MARTA_PR ***
grant SELECT                                                                 on MARTA_PR        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MARTA_PR        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MARTA_PR.sql =========*** End *** =====
PROMPT ===================================================================================== 
