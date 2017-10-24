

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NAL_2.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view NAL_2 ***

  CREATE OR REPLACE FORCE VIEW BARS.NAL_2 ("ACCC", "FDAT", "DK", "S", "NLS", "REF", "ACC", "REC", "NAZN") AS 
  SELECT a.accc,o.fdat,o.dk,o.s,a.nls,o.ref,o.acc, 0, p.nazn
FROM   opldok o, oper p, accounts a
WHERE a.accc is not NULL  AND
      a.acc=o.acc AND p.ref=o.ref AND o.sos=5 AND
      o.tt not in ('R01' ,'D01' )
UNION ALL
SELECT a.accc,o.fdat,o.dk,o.s,a.nls,o.ref,o.acc,p.rec,
       p.nazn
FROM opldok o, arc_rrp p, accounts a
WHERE a.accc is not NULL AND
      a.acc=o.acc AND p.ref=o.ref AND o.sos=5 AND
      o.tt  in ('R01' ,'D01' );

PROMPT *** Create  grants  NAL_2 ***
grant SELECT                                                                 on NAL_2           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NAL_2           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NAL_2.sql =========*** End *** ========
PROMPT ===================================================================================== 
