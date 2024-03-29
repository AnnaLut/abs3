

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_ARCH_102.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view RNBU_TRACE_ARCH_102 ***

  CREATE OR REPLACE FORCE VIEW BARS.RNBU_TRACE_ARCH_102 ("COL_P1", "COL_P2", "COL_P3", "COL_P4", "COL_P5", "COL_P6", "COL_P7", "KODF", "DATF", "NLS", "KV", "ODATE", "KODP", "ZNAP", "NBUC", "ISP", "RNK", "ACC", "REF", "COMM", "ND", "MDATE", "TOBO") AS 
  select substr(kodp,1,1) COL_P1, substr(kodp,2,4) COL_P2, substr(kodp,6,1) COL_P3, substr(kodp,7,3) COL_P4, substr(kodp,10,1) COL_P5, substr(kodp,11,1) COL_P6, znap COL_P7,  RNBU_TRACE_ARCH."KODF",RNBU_TRACE_ARCH."DATF",RNBU_TRACE_ARCH."NLS",RNBU_TRACE_ARCH."KV",RNBU_TRACE_ARCH."ODATE",RNBU_TRACE_ARCH."KODP",RNBU_TRACE_ARCH."ZNAP",RNBU_TRACE_ARCH."NBUC",RNBU_TRACE_ARCH."ISP",RNBU_TRACE_ARCH."RNK",RNBU_TRACE_ARCH."ACC",RNBU_TRACE_ARCH."REF",RNBU_TRACE_ARCH."COMM",RNBU_TRACE_ARCH."ND",RNBU_TRACE_ARCH."MDATE",RNBU_TRACE_ARCH."TOBO" from RNBU_TRACE_ARCH;

PROMPT *** Create  grants  RNBU_TRACE_ARCH_102 ***
grant SELECT                                                                 on RNBU_TRACE_ARCH_102 to BARSREADER_ROLE;
grant SELECT                                                                 on RNBU_TRACE_ARCH_102 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_ARCH_102 to RPBN002;
grant SELECT                                                                 on RNBU_TRACE_ARCH_102 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_ARCH_102.sql =========*** En
PROMPT ===================================================================================== 
