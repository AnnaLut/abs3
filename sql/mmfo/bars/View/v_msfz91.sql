

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MSFZ91.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MSFZ91 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MSFZ91 ("VIDD", "ND", "SDATE", "WDATE", "SOS", "RNK", "CC_ID", "KV", "KOL", "SS", "SS1", "SN", "SN1", "SP", "SP1", "SDI", "SDI1", "SPN", "SPN1", "SNA", "SNA1", "SNO", "SNO1", "S36", "S361", "ISG", "ISG1", "SG", "SG1") AS 
  select x."VIDD",x."ND",x."SDATE",x."WDATE",x."SOS",x."RNK",x."CC_ID",x."KV",x."KOL",x."SS",x."SS1",x."SN",x."SN1",x."SP",x."SP1",x."SDI",x."SDI1",x."SPN",x."SPN1",x."SNA",x."SNA1",x."SNO",x."SNO1",x."S36",x."S361",x."ISG",x."ISG1",x."SG",x."SG1" from 
(select d.vidd, d.nd,  d.sdate, d.wdate , d.sos, d.rnk, d.cc_id, a.kv, count(*) kol , 
     sum ( decode(a.tip,'SS ',1,0) ) SS , - sum ( decode( a.tip,'SS ',a.ostc,0) )/100 SS1 ,     
     sum ( decode(a.tip,'SN ',1,0) ) SN , - sum ( decode( a.tip,'SN ',a.ostc,0) )/100 SN1 ,     
     sum ( decode(a.tip,'SP ',1,0) ) SP , - sum ( decode( a.tip,'SP ',a.ostc,0) )/100 SP1 ,
     sum ( decode(a.tip,'SDI',1,0) ) SDI, - sum ( decode( a.tip,'SDI',a.ostc,0) )/100 SDI1,     
     sum ( decode(a.tip,'SPN',1,0) ) SPN, - sum ( decode( a.tip,'SPN',a.ostc,0) )/100 SPN1,
     sum ( decode(a.tip,'SNA',1,0) ) SNA, - sum ( decode( a.tip,'SNA',a.ostc,0) )/100 SNA1,     
     sum ( decode(a.tip,'SNO',1,0) ) SNO, - sum ( decode( a.tip,'SNO',a.ostc,0) )/100 SNO1,     
     sum ( decode(a.tip,'S36',1,0) ) S36, - sum ( decode( a.tip,'S36',a.ostc,0) )/100 S361,
     sum ( decode(a.tip,'ISG',1,0) ) ISG, - sum ( decode( a.tip,'ISG',a.ostc,0) )/100 ISG1,     
     sum ( decode(a.tip,'SG ',1,0) ) SG , - sum ( decode( a.tip,'SG ',a.ostc,0) )/100 SG1           
 from  bars.cc_deal  d,  bars.nd_acc n, bars.accounts a 
 where d.vidd in (1,2,3) and a.acc= n.acc and n.nd = d.nd and a.tip not in ('LIM','SK9','SD ','ODB', 'ZZI')
   and a.dazs is null and d.rnk = a.rnk and a.nls < '4' and a.nls >'2' and a.nbs not like '357_' and  d.sos < 14 
--   and d.nd = 108067
 group by d.vidd, d.nd,  d.sdate, d.wdate , d.sos, a.kv , d.rnk, d.cc_id
 ) x;

PROMPT *** Create  grants  V_MSFZ91 ***
grant SELECT                                                                 on V_MSFZ91        to BARSREADER_ROLE;
grant SELECT                                                                 on V_MSFZ91        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MSFZ91.sql =========*** End *** =====
PROMPT ===================================================================================== 
