

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_114.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_114 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_114 ("FDAT", "KV", "NBS", "NLS", "OST", "PR_V", "PR_G", "PR_POG") AS 
  SELECT f.fdat,
       a.kv,
       a.nbs,
       a.nls,
      -fost(a.acc,f.fdat),
       fdos(i.acc,f.fdat,f.fdat),
    gl.p_icurval( a.kv, fdos(i.acc,f.fdat,f.fdat), f.fdat ),
       fkos(i.acc,f.fdat,f.fdat)
FROM   accounts a,
       fdat     f,
       int_accn i,
       cc_add   d
WHERE  i.acc=a.acc  AND
       d.accs=a.acc;

PROMPT *** Create  grants  KU_114 ***
grant SELECT                                                                 on KU_114          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_114          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_114.sql =========*** End *** =======
PROMPT ===================================================================================== 
