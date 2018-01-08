

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEBREG_RES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEBREG_RES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEBREG_RES ("REQUESTID", "REGDATETIME", "MFO", "OKPO", "NMK", "KV", "SUMM", "DEBDATE", "DEBOFFDATE", "ADR", "NB", "OSN") AS 
  SELECT DEBREG_RES.requestid,
            DEBREG_RES.REGDATETIME,
            DEBREG_RES.MFO,
            DEBREG_RES.OKPO,
            DEBREG_RES.NMK,
            DEBREG_RES.KV,
            DEBREG_RES.SUMM / 100,
            DEBREG_RES.DEBDATE,
            DEBREG_RES.DEBOFFDATE,
            DEBREG_RES.ADR,
            b.NB,
            DEBREG_RES.OSN
       FROM DEBREG_RES, banks b
      WHERE DEBREG_RES.MFO = b.mfo(+)
   ORDER BY requestid;

PROMPT *** Create  grants  V_DEBREG_RES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEBREG_RES    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEBREG_RES    to DEB_REG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEBREG_RES.sql =========*** End *** =
PROMPT ===================================================================================== 
