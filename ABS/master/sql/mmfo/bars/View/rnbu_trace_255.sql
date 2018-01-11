

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_255.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view RNBU_TRACE_255 ***

  CREATE OR REPLACE FORCE VIEW BARS.RNBU_TRACE_255 ("COL_P5", "COL_P1", "COL_P2", "COL_P3", "COL_P4", "COL_P6", "COL_P7", "RECID", "USERID", "NLS", "KV", "ODATE", "KODP", "ZNAP", "NBUC", "ISP", "RNK", "ACC", "REF", "COMM", "ND", "MDATE", "TOBO") AS 
  select substr(kodp,10,4) COL_P5, substr(kodp,1,2) COL_P1, substr(kodp,3,1) COL_P2, substr(kodp,4,3) COL_P3, substr(kodp,7,3) COL_P4, substr(nbuc,1,12) COL_P6, znap COL_P7,  RNBU_TRACE."RECID",RNBU_TRACE."USERID",RNBU_TRACE."NLS",RNBU_TRACE."KV",RNBU_TRACE."ODATE",RNBU_TRACE."KODP",RNBU_TRACE."ZNAP",RNBU_TRACE."NBUC",RNBU_TRACE."ISP",RNBU_TRACE."RNK",RNBU_TRACE."ACC",RNBU_TRACE."REF",RNBU_TRACE."COMM",RNBU_TRACE."ND",RNBU_TRACE."MDATE",RNBU_TRACE."TOBO" from RNBU_TRACE;

PROMPT *** Create  grants  RNBU_TRACE_255 ***
grant SELECT                                                                 on RNBU_TRACE_255  to BARSREADER_ROLE;
grant SELECT                                                                 on RNBU_TRACE_255  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_255  to RPBN002;
grant SELECT                                                                 on RNBU_TRACE_255  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_255.sql =========*** End ***
PROMPT ===================================================================================== 
