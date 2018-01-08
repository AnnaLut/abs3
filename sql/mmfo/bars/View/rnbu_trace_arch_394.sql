

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_ARCH_394.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view RNBU_TRACE_ARCH_394 ***

  CREATE OR REPLACE FORCE VIEW BARS.RNBU_TRACE_ARCH_394 ("COL_P1", "COL_P2", "COL_P4", "COL_P3", "COL_P5", "KODF", "DATF", "NLS", "KV", "ODATE", "KODP", "ZNAP", "NBUC", "ISP", "RNK", "ACC", "REF", "COMM", "ND", "MDATE", "TOBO") AS 
  select substr(kodp,1,2) COL_P1, substr(kodp,3,2) COL_P2, substr(kodp,6,3) COL_P4, substr(kodp,5,1) COL_P3, znap COL_P5,  RNBU_TRACE_ARCH."KODF",RNBU_TRACE_ARCH."DATF",RNBU_TRACE_ARCH."NLS",RNBU_TRACE_ARCH."KV",RNBU_TRACE_ARCH."ODATE",RNBU_TRACE_ARCH."KODP",RNBU_TRACE_ARCH."ZNAP",RNBU_TRACE_ARCH."NBUC",RNBU_TRACE_ARCH."ISP",RNBU_TRACE_ARCH."RNK",RNBU_TRACE_ARCH."ACC",RNBU_TRACE_ARCH."REF",RNBU_TRACE_ARCH."COMM",RNBU_TRACE_ARCH."ND",RNBU_TRACE_ARCH."MDATE",RNBU_TRACE_ARCH."TOBO" from RNBU_TRACE_ARCH;

PROMPT *** Create  grants  RNBU_TRACE_ARCH_394 ***
grant SELECT                                                                 on RNBU_TRACE_ARCH_394 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_ARCH_394 to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_ARCH_394.sql =========*** En
PROMPT ===================================================================================== 
