

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_9200.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_9200 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_9200 ("NLS", "KV", "KF", "RNK", "FIN", "VKR", "COMM", "PD", "NOT_LIM", "FDAT") AS 
  select a.nls,
            a.kv,
            r.kf,
            r.rnk,
            r.fin,
            r.VKR,
            r.comm,
            r.PD,
            r.NOT_LIM,
            ROUND (gl.bd, 'mm') FDAT
     from REZ_PAR_9200 r, accounts a where r.fdat = ROUND (gl.bd, 'mm') and r.nd=a.acc (+);

PROMPT *** Create  grants  V_9200 ***
grant SELECT                                                                 on V_9200          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_9200          to START1;
grant SELECT                                                                 on V_9200          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_9200.sql =========*** End *** =======
PROMPT ===================================================================================== 
