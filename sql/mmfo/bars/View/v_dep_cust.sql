

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEP_CUST.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEP_CUST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEP_CUST ("RNK") AS 
  SELECT rnk
     FROM accounts
    WHERE (   nls LIKE '2560%'
           OR nls LIKE '2560%'
           OR nls LIKE '2570%'
           OR nls LIKE '2600%'
           OR nls LIKE '2601%'
           OR nls LIKE '2602%'
           OR nls LIKE '2604%'
           OR nls LIKE '2605%'
           OR nls LIKE '2606%'
           OR nls LIKE '2610%'
           OR nls LIKE '2611%'
           OR nls LIKE '2615%'
           OR nls LIKE '2620%'
           OR nls LIKE '2622%'
           OR nls LIKE '2625%'
           OR nls LIKE '2630%'
           OR nls LIKE '2635%'
           OR nls LIKE '2640%'
           OR nls LIKE '2641%'
           OR nls LIKE '2642%'
           OR nls LIKE '2643%'
           OR nls LIKE '2650%'
           OR nls LIKE '2651%'
           OR nls LIKE '2652%'
           OR nls LIKE '2655%')
          OR (nls LIKE '2603%' AND kv = 980) AND dazs IS NULL;

PROMPT *** Create  grants  V_DEP_CUST ***
grant SELECT                                                                 on V_DEP_CUST      to BARSREADER_ROLE;
grant SELECT                                                                 on V_DEP_CUST      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DEP_CUST      to START1;
grant SELECT                                                                 on V_DEP_CUST      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEP_CUST.sql =========*** End *** ===
PROMPT ===================================================================================== 
