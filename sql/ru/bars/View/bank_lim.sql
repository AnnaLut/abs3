

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BANK_LIM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view BANK_LIM ***

  CREATE OR REPLACE FORCE VIEW BARS.BANK_LIM ("RNK", "NMK", "MFO", "LIM", "OSTB") AS 
  SELECT a.rnk, a.nmk, nvl(b.mfo,0),
        nvl(a.lim,0),  rnk_ostb(a.rnk)
  FROM customer a, custbank b
  WHERE a.DATE_OFF is null AND a.custtype=1 AND b.rnk=a.rnk
        and nvl(b.mfo,0)<>f_ourmfo;

PROMPT *** Create  grants  BANK_LIM ***
grant SELECT                                                                 on BANK_LIM        to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BANK_LIM.sql =========*** End *** =====
PROMPT ===================================================================================== 
