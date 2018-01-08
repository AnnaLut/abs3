

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_67.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view RNBU_TRACE_67 ***

  CREATE OR REPLACE FORCE VIEW BARS.RNBU_TRACE_67 ("COL_P2", "COL_P1", "COL_P3", "RECID", "USERID", "NLS", "KV", "ODATE", "KODP", "ZNAP", "NBUC", "ISP", "RNK", "ACC", "REF", "COMM", "ND", "MDATE", "TOBO") AS 
  select substr(kodp,3,3) COL_P2, substr(kodp,1,2) COL_P1, znap COL_P3,  RNBU_TRACE."RECID",RNBU_TRACE."USERID",RNBU_TRACE."NLS",RNBU_TRACE."KV",RNBU_TRACE."ODATE",RNBU_TRACE."KODP",RNBU_TRACE."ZNAP",RNBU_TRACE."NBUC",RNBU_TRACE."ISP",RNBU_TRACE."RNK",RNBU_TRACE."ACC",RNBU_TRACE."REF",RNBU_TRACE."COMM",RNBU_TRACE."ND",RNBU_TRACE."MDATE",RNBU_TRACE."TOBO" from RNBU_TRACE;

PROMPT *** Create  grants  RNBU_TRACE_67 ***
grant SELECT                                                                 on RNBU_TRACE_67   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE_67   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_67.sql =========*** End *** 
PROMPT ===================================================================================== 
