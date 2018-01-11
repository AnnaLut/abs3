

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MSFZ9.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MSFZ9 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MSFZ9 ("VIDD", "ND", "SDATE", "WDATE", "SOS", "RNK", "CC_ID", "KV", "KOL", "SS", "SS1", "SN", "SN1", "SP", "SP1", "SDI", "SDI1", "SPN", "SPN1", "SNA", "SNA1", "SNO", "SNO1", "S36", "S361", "ISG", "ISG1", "SG", "SG1") AS 
  select X."VIDD",X."ND",X."SDATE",X."WDATE",X."SOS",X."RNK",X."CC_ID",X."KV",X."KOL",X."SS",X."SS1",X."SN",X."SN1",X."SP",X."SP1",X."SDI",X."SDI1",X."SPN",X."SPN1",X."SNA",X."SNA1",X."SNO",X."SNO1",X."S36",X."S361",X."ISG",X."ISG1",X."SG",X."SG1"  
FROM (
select Z.vidd, Z.nd , Z.sdate, Z.wdate, Z.sos, Z.rnk, Z.cc_id,  NULL KV, NULL kol ,
     sum (Z.SS ) SS ,  sum ( gl.p_icurval(Z.kv, Z.SS1 *100, gl.bd) ) / 100 SS1  ,     
     sum (Z.SN ) SN ,  sum ( gl.p_icurval(Z.kv, Z.SN1 *100, gl.bd) ) / 100 SN1  ,     
     sum (Z.SP ) SP ,  sum ( gl.p_icurval(Z.kv, Z.SP1 *100, gl.bd) ) / 100 SP1  ,     
     sum (Z.SDI) SDI,  sum ( gl.p_icurval(Z.kv, Z.SDI1*100, gl.bd) ) / 100 SDI1 ,     
     sum (Z.SPN) SPN,  sum ( gl.p_icurval(Z.kv, Z.SPN1*100, gl.bd) ) / 100 SPN1 ,     
     sum (Z.SNA) SNA,  sum ( gl.p_icurval(Z.kv, Z.SNA1*100, gl.bd) ) / 100 SNA1 ,     
     sum (Z.SNO) SNO,  sum ( gl.p_icurval(Z.kv, Z.SNO1*100, gl.bd) ) / 100 SNO1 ,     
     sum (Z.S36) S36,  sum ( gl.p_icurval(Z.kv, Z.S361*100, gl.bd) ) / 100 S361 ,     
     sum (Z.ISG) ISG,  sum ( gl.p_icurval(Z.kv, Z.ISG1*100, gl.bd) ) / 100 ISG1 ,     
     sum ( Z.SG)  SG,  sum ( gl.p_icurval(Z.kv, Z.SG1 *100, gl.bd) ) / 100  SG1      
from bars.v_MSFZ91 Z 
group by Z.vidd, Z.nd,  Z.sdate, Z.wdate , Z.sos,  Z.rnk, Z.cc_id 
HAVING sum (Z.SS ) > 1 
  ) X
WHERE X.SS1 + X.SP1 <> 0;

PROMPT *** Create  grants  V_MSFZ9 ***
grant SELECT                                                                 on V_MSFZ9         to BARSREADER_ROLE;
grant SELECT                                                                 on V_MSFZ9         to START1;
grant SELECT                                                                 on V_MSFZ9         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MSFZ9.sql =========*** End *** ======
PROMPT ===================================================================================== 
