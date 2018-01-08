

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SPARAM_LIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SPARAM_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SPARAM_LIST ("NBS", "SPID", "NAME", "SEMANTIC") AS 
  SELECT b.nbs,
            a.spid,
            a.name,
            a.semantic
       FROM SPARAM_LIST a, V_PS_LIST b
      WHERE a.spid NOT IN (SELECT spid
                             FROM PS_SPARAM p
                            WHERE p.nbs = b.nbs)
   ORDER BY a.spid;

PROMPT *** Create  grants  V_SPARAM_LIST ***
grant SELECT                                                                 on V_SPARAM_LIST   to BARSREADER_ROLE;
grant SELECT                                                                 on V_SPARAM_LIST   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SPARAM_LIST   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SPARAM_LIST.sql =========*** End *** 
PROMPT ===================================================================================== 
