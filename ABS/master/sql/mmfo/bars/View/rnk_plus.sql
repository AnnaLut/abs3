

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNK_PLUS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view RNK_PLUS ***

  CREATE OR REPLACE FORCE VIEW BARS.RNK_PLUS ("RNK", "NBS", "OSTB") AS 
  SELECT c.rnk, s.nbs, gl.p_icurval(s.kv,s.ostb,gl.bd)
  FROM   accounts s, cust_acc c
  WHERE  c.acc=s.acc
  UNION ALL
  SELECT c.rnk, substr(i.DEB,1,4), -gl.p_icurval(i.kvd,i.s,gl.bd )*100
  FROM   igra i, accounts a, cust_acc c
  WHERE  i.deb=a.nls AND
         i.kvd=a.kv  AND
         a.acc=c.acc
  UNION ALL
  SELECT c.rnk, substr(KRD,1,4),
         gl.p_icurval(i.kvk,iif_n(i.kvd,i.kvk,i.s1,i.s,i.s1),gl.bd)*100
  FROM   igra i, accounts a, cust_acc c
  WHERE  i.krd=a.nls AND
         i.kvk=a.kv  AND
         a.acc=c.acc;

PROMPT *** Create  grants  RNK_PLUS ***
grant SELECT                                                                 on RNK_PLUS        to BARSREADER_ROLE;
grant SELECT                                                                 on RNK_PLUS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNK_PLUS        to START1;
grant SELECT                                                                 on RNK_PLUS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNK_PLUS.sql =========*** End *** =====
PROMPT ===================================================================================== 
