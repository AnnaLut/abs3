

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OTCN_TRACE_70_DATF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OTCN_TRACE_70_DATF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OTCN_TRACE_70_DATF ("REF", "DATF") AS 
  SELECT DISTINCT REF, DATF
     FROM OTCN_TRACE_70;

PROMPT *** Create  grants  V_OTCN_TRACE_70_DATF ***
grant SELECT                                                                 on V_OTCN_TRACE_70_DATF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OTCN_TRACE_70_DATF to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OTCN_TRACE_70_DATF.sql =========*** E
PROMPT ===================================================================================== 
