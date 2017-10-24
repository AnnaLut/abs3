

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_108.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_108 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_108 ("DATK", "RNKK", "NMK", "NKD", "CC_ID", "NZD", "RNKZ", "NMZ", "OKPOZ", "KVZ", "NLSZ", "SUMZ", "PAWN", "MPAWN") AS 
  SELECT d.wdate, d.rnk, k.nmk, d.nd,d.cc_id,z.idz, c.rnk, c.nmk, c.okpo,
       a.kv, a.nls, a.ostc, z.pawn,z.mpawn
FROM customer c,  cc_accp  z,  cc_deal  d,  accounts a,  customer k
WHERE z.nd =d.nd     AND        z.rnk=c.rnk    AND
      z.acc=a.acc    AND        a.dazs is null AND
      k.rnk=d.rnk    AND d.vidd in (1,2);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_108.sql =========*** End *** =======
PROMPT ===================================================================================== 
