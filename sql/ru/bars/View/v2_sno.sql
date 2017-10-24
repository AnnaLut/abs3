

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V2_SNO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V2_SNO ***

  CREATE OR REPLACE FORCE VIEW BARS.V2_SNO ("OTM", "SPN", "ND", "KV", "NLS", "ID", "DAT", "S", "OST1", "OST2", "SA") AS 
  SELECT t.OTM,  t.ir SPN, t.br ND, t.op KV, TO_CHAR (t.BRN) NLS,  t.ID,   t.DAT,     t.s/100  S,
         (t.ostf - (SELECT NVL (SUM(s), 0) FROM tmp_sno WHERE dat <  t.dat))/ 100  OST1,
         (t.ostf - (SELECT NVL (SUM(s), 0) FROM tmp_sno WHERE dat <= t.dat))/ 100  OST2,  t.sa/100  SA  FROM tmp_sno t ;

PROMPT *** Create  grants  V2_SNO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V2_SNO          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V2_SNO.sql =========*** End *** =======
PROMPT ===================================================================================== 
