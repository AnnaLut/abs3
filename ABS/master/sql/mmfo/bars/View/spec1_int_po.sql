

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SPEC1_INT_PO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view SPEC1_INT_PO ***

  CREATE OR REPLACE FORCE VIEW BARS.SPEC1_INT_PO ("ACC", "NLS", "KV", "NMS", "P080", "OB22", "MFO", "R020_FA", "F_11", "OB88") AS 
  SELECT a.acc, a.nls, a.kv, a.nms,
b.p080, b.ob22, b.mfo, b.r020_fa, b.f_11, b.ob88
FROM accounts a, specparam_int b,sb_p0853 n
WHERE a.acc=b.acc and a.nbs=n.r020
UNION ALL
SELECT a.acc, a.nls, a.kv, a.nms,
b.p080, b.ob22, b.mfo, b.r020_fa, b.f_11, b.ob88
FROM accounts a, specparam_int b,sb_p0853 n
WHERE a.acc=b.acc and a.nbs=n.r020_fa
 ;

PROMPT *** Create  grants  SPEC1_INT_PO ***
grant SELECT                                                                 on SPEC1_INT_PO    to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on SPEC1_INT_PO    to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on SPEC1_INT_PO    to NALOG;
grant SELECT                                                                 on SPEC1_INT_PO    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPEC1_INT_PO    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SPEC1_INT_PO.sql =========*** End *** =
PROMPT ===================================================================================== 
