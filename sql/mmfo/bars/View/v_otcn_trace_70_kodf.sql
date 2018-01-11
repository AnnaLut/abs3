

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OTCN_TRACE_70_KODF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OTCN_TRACE_70_KODF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OTCN_TRACE_70_KODF ("REF", "KODF") AS 
  SELECT DISTINCT REF, KODF
     FROM OTCN_TRACE_70;

PROMPT *** Create  grants  V_OTCN_TRACE_70_KODF ***
grant SELECT                                                                 on V_OTCN_TRACE_70_KODF to BARSREADER_ROLE;
grant SELECT                                                                 on V_OTCN_TRACE_70_KODF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OTCN_TRACE_70_KODF to START1;
grant SELECT                                                                 on V_OTCN_TRACE_70_KODF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OTCN_TRACE_70_KODF.sql =========*** E
PROMPT ===================================================================================== 
