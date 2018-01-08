

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_104.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_104 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_104 ("FDAT", "KV", "NBS", "NLS", "OST", "PR_V", "PR_G", "PR_POG") AS 
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

PROMPT *** Create  grants  KU_104 ***
grant SELECT                                                                 on KU_104          to BARSREADER_ROLE;
grant SELECT                                                                 on KU_104          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_104          to START1;
grant SELECT                                                                 on KU_104          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_104.sql =========*** End *** =======
PROMPT ===================================================================================== 
