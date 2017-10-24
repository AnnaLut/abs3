

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



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MONITOR_FOR_DOCS_VEGA2.sql =========*
PROMPT ===================================================================================== 
