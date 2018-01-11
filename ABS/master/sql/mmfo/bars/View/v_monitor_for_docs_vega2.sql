

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MONITOR_FOR_DOCS_VEGA2.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MONITOR_FOR_DOCS_VEGA2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MONITOR_FOR_DOCS_VEGA2 ("MFO", "CNT") AS 
  select  mfo, count(ref) cnt from
(select unique(s.ref) ref, substr(branch, 2, 6) mfo from sgn_int_store s, oper o where s.ref=o.ref and pdat >= trunc(sysdate))
group by mfo
order by mfo
;

PROMPT *** Create  grants  V_MONITOR_FOR_DOCS_VEGA2 ***
grant SELECT                                                                 on V_MONITOR_FOR_DOCS_VEGA2 to BARSREADER_ROLE;
grant SELECT                                                                 on V_MONITOR_FOR_DOCS_VEGA2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MONITOR_FOR_DOCS_VEGA2.sql =========*
PROMPT ===================================================================================== 
