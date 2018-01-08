

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_INT_ARCH_116.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view RNBU_TRACE_INT_ARCH_116 ***

  CREATE OR REPLACE FORCE VIEW BARS.RNBU_TRACE_INT_ARCH_116 ("COL_P1", "COL_P2", "COL_P8", "COL_P4", "COL_P3", "COL_P5", "COL_P6", "COL_P7", "COL_P9", "KODF", "DATF", "NLS", "KV", "ODATE", "KODP", "ZNAP", "NBUC", "ISP", "RNK", "ACC", "REF", "COMM", "ND", "MDATE", "TOBO") AS 
  select substr(kodp,1,1) COL_P1, substr(kodp,2,4) COL_P2, substr(kodp,11,3) COL_P8, substr(kodp,7,1) COL_P4, substr(kodp,6,1) COL_P3, substr(kodp,8,1) COL_P5, substr(kodp,9,1) COL_P6, substr(kodp,10,1) COL_P7, znap COL_P9,  RNBU_TRACE_INT_ARCH."KODF",RNBU_TRACE_INT_ARCH."DATF",RNBU_TRACE_INT_ARCH."NLS",RNBU_TRACE_INT_ARCH."KV",RNBU_TRACE_INT_ARCH."ODATE",RNBU_TRACE_INT_ARCH."KODP",RNBU_TRACE_INT_ARCH."ZNAP",RNBU_TRACE_INT_ARCH."NBUC",RNBU_TRACE_INT_ARCH."ISP",RNBU_TRACE_INT_ARCH."RNK",RNBU_TRACE_INT_ARCH."ACC",RNBU_TRACE_INT_ARCH."REF",RNBU_TRACE_INT_ARCH."COMM",RNBU_TRACE_INT_ARCH."ND",RNBU_TRACE_INT_ARCH."MDATE",RNBU_TRACE_INT_ARCH."TOBO" from RNBU_TRACE_INT_ARCH;

PROMPT *** Create  grants  RNBU_TRACE_INT_ARCH_116 ***
grant SELECT                                                                 on RNBU_TRACE_INT_ARCH_116 to BARSREADER_ROLE;
grant SELECT                                                                 on RNBU_TRACE_INT_ARCH_116 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_INT_ARCH_116 to RPBN002;
grant SELECT                                                                 on RNBU_TRACE_INT_ARCH_116 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_INT_ARCH_116.sql =========**
PROMPT ===================================================================================== 
