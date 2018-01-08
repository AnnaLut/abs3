

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KREDITY.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KREDITY ***

  CREATE OR REPLACE FORCE VIEW BARS.KREDITY ("NBS", "FDAT", "KV", "SACC", "SNLS", "SOST", "NACC", "NNLS", "NOST") AS 
  SELECT s.nbs,s.fdat,s.kv,s.acc,s.nls,s.ost,ss.acc,ss.nls,ss.ost
FROM   sal ss, sal s,int_accn i
WHERE  i.acc in (select accs from cc_add) AND
       ss.fdat=s.fdat  AND
       i.acc=s.acc;

PROMPT *** Create  grants  KREDITY ***
grant SELECT                                                                 on KREDITY         to BARSREADER_ROLE;
grant SELECT                                                                 on KREDITY         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KREDITY         to START1;
grant SELECT                                                                 on KREDITY         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KREDITY.sql =========*** End *** ======
PROMPT ===================================================================================== 
