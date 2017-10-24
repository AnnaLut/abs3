

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEBREG_QUERY_C.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEBREG_QUERY_C ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEBREG_QUERY_C ("REQUESTID", "SOS", "NMK", "OKPO", "QUERYTYPE", "OSN") AS 
  SELECT requestid,
                SOS,
                NMK,
                OKPO,
                QUERYTYPE,
                osn
           FROM DEBREG_QUERY
          WHERE PHASEID = 'C'
       ORDER BY OKPO;

PROMPT *** Create  grants  V_DEBREG_QUERY_C ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEBREG_QUERY_C to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEBREG_QUERY_C to DEB_REG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEBREG_QUERY_C.sql =========*** End *
PROMPT ===================================================================================== 
