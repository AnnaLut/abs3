

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_338.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view RNBU_TRACE_338 ***

  CREATE OR REPLACE FORCE VIEW BARS.RNBU_TRACE_338 ("COL_P1", "COL_P2", "COL_P3", "COL_P4", "COL_P5", "COL_P6", "COL_P7", "COL_P8", "COL_P9", "RECID", "USERID", "NLS", "KV", "ODATE", "KODP", "ZNAP", "NBUC", "ISP", "RNK", "ACC", "REF", "COMM", "ND", "MDATE", "TOBO") AS 
  select substr(kodp,1,2) COL_P1, substr(kodp,3,2) COL_P2, substr(kodp,5,2) COL_P3, substr(kodp,7,2) COL_P4, substr(kodp,9,1) COL_P5, substr(kodp,10,1) COL_P6, substr(kodp,11,2) COL_P7, substr(kodp,13,3) COL_P8, znap COL_P9,  RNBU_TRACE."RECID",RNBU_TRACE."USERID",RNBU_TRACE."NLS",RNBU_TRACE."KV",RNBU_TRACE."ODATE",RNBU_TRACE."KODP",RNBU_TRACE."ZNAP",RNBU_TRACE."NBUC",RNBU_TRACE."ISP",RNBU_TRACE."RNK",RNBU_TRACE."ACC",RNBU_TRACE."REF",RNBU_TRACE."COMM",RNBU_TRACE."ND",RNBU_TRACE."MDATE",RNBU_TRACE."TOBO" from RNBU_TRACE;

PROMPT *** Create  grants  RNBU_TRACE_338 ***
grant SELECT                                                                 on RNBU_TRACE_338  to BARSREADER_ROLE;
grant SELECT                                                                 on RNBU_TRACE_338  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_338  to RPBN002;
grant SELECT                                                                 on RNBU_TRACE_338  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_338.sql =========*** End ***
PROMPT ===================================================================================== 
