

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_50.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view RNBU_TRACE_50 ***

  CREATE OR REPLACE FORCE VIEW BARS.RNBU_TRACE_50 ("COL_P1", "COL_P2", "COL_P3", "COL_P4", "COL_P5", "COL_P6", "COL_P7", "COL_P8", "COL_P9", "COL_P10", "COL_P11", "RECID", "USERID", "NLS", "KV", "ODATE", "KODP", "ZNAP", "NBUC", "ISP", "RNK", "ACC", "REF", "COMM", "ND", "MDATE", "TOBO") AS 
  select substr(kodp,1,1) COL_P1, substr(kodp,2,3) COL_P2, substr(kodp,5,1) COL_P3, substr(kodp,6,1) COL_P4, substr(kodp,7,1) COL_P5, substr(kodp,8,3) COL_P6, substr(kodp,11,2) COL_P7, substr(kodp,13,3) COL_P8, substr(kodp,16,3) COL_P9, substr(kodp,19,1) COL_P10, znap COL_P11,  RNBU_TRACE."RECID",RNBU_TRACE."USERID",RNBU_TRACE."NLS",RNBU_TRACE."KV",RNBU_TRACE."ODATE",RNBU_TRACE."KODP",RNBU_TRACE."ZNAP",RNBU_TRACE."NBUC",RNBU_TRACE."ISP",RNBU_TRACE."RNK",RNBU_TRACE."ACC",RNBU_TRACE."REF",RNBU_TRACE."COMM",RNBU_TRACE."ND",RNBU_TRACE."MDATE",RNBU_TRACE."TOBO" from RNBU_TRACE;

PROMPT *** Create  grants  RNBU_TRACE_50 ***
grant SELECT                                                                 on RNBU_TRACE_50   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_50   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_50.sql =========*** End *** 
PROMPT ===================================================================================== 
