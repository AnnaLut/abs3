

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_62.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view RNBU_TRACE_62 ***

  CREATE OR REPLACE FORCE VIEW BARS.RNBU_TRACE_62 ("COL_P1", "COL_P2", "COL_P5", "COL_P4", "COL_P3", "RECID", "USERID", "NLS", "KV", "ODATE", "KODP", "ZNAP", "NBUC", "ISP", "RNK", "ACC", "REF", "COMM", "ND", "MDATE", "TOBO") AS 
  select substr(kodp,1,1) COL_P1, substr(kodp,2,4) COL_P2, znap COL_P5, substr(kodp,8,3) COL_P4, substr(kodp,6,2) COL_P3,  RNBU_TRACE."RECID",RNBU_TRACE."USERID",RNBU_TRACE."NLS",RNBU_TRACE."KV",RNBU_TRACE."ODATE",RNBU_TRACE."KODP",RNBU_TRACE."ZNAP",RNBU_TRACE."NBUC",RNBU_TRACE."ISP",RNBU_TRACE."RNK",RNBU_TRACE."ACC",RNBU_TRACE."REF",RNBU_TRACE."COMM",RNBU_TRACE."ND",RNBU_TRACE."MDATE",RNBU_TRACE."TOBO" from RNBU_TRACE;

PROMPT *** Create  grants  RNBU_TRACE_62 ***
grant SELECT                                                                 on RNBU_TRACE_62   to BARSREADER_ROLE;
grant SELECT                                                                 on RNBU_TRACE_62   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_62   to RPBN002;
grant SELECT                                                                 on RNBU_TRACE_62   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_62.sql =========*** End *** 
PROMPT ===================================================================================== 
