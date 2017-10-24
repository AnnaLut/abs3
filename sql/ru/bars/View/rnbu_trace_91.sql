

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_91.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view RNBU_TRACE_91 ***

  CREATE OR REPLACE FORCE VIEW BARS.RNBU_TRACE_91 ("COL_P1", "COL_P2", "RECID", "USERID", "NLS", "KV", "ODATE", "KODP", "ZNAP", "NBUC", "ISP", "RNK", "ACC", "REF", "COMM", "ND", "MDATE", "TOBO") AS 
  select substr(kodp,1,2) COL_P1, znap COL_P2,  RNBU_TRACE."RECID",RNBU_TRACE."USERID",RNBU_TRACE."NLS",RNBU_TRACE."KV",RNBU_TRACE."ODATE",RNBU_TRACE."KODP",RNBU_TRACE."ZNAP",RNBU_TRACE."NBUC",RNBU_TRACE."ISP",RNBU_TRACE."RNK",RNBU_TRACE."ACC",RNBU_TRACE."REF",RNBU_TRACE."COMM",RNBU_TRACE."ND",RNBU_TRACE."MDATE",RNBU_TRACE."TOBO" from RNBU_TRACE;

PROMPT *** Create  grants  RNBU_TRACE_91 ***
grant SELECT                                                                 on RNBU_TRACE_91   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RNBU_TRACE_91.sql =========*** End *** 
PROMPT ===================================================================================== 
