

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEBREG_RES_S.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEBREG_RES_S ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEBREG_RES_S ("REQUESTID", "OKPO", "NMK", "ADR", "CUSTTYPE", "REZID", "EVENTTYPE", "EVENTDATE", "DEBNUM", "KV", "CRDAGRNUM", "CRDDATE", "SUMM", "DEBDATE", "REGDATETIME", "FILENAME", "OSN") AS 
  SELECT REQUESTID,
          OKPO,
          NMK,
          ADR,
          CUSTTYPE,
          REZID,
          EVENTTYPE,
          DEBREG_RES_S.EVENTDATE,
          DEBREG_RES_S.DEBNUM,
          DEBREG_RES_S.KV,
          DEBREG_RES_S.CRDAGRNUM,
          DEBREG_RES_S.CRDDATE,
          DEBREG_RES_S.SUMM / 100 SUMM,
          DEBREG_RES_S.DEBDATE,
          DEBREG_RES_S.REGDATETIME,
          DEBREG_RES_S.FILENAME,
          DEBREG_RES_S.OSN
     FROM DEBREG_RES_S;

PROMPT *** Create  grants  V_DEBREG_RES_S ***
grant SELECT                                                                 on V_DEBREG_RES_S  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEBREG_RES_S  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEBREG_RES_S  to DEB_REG;
grant SELECT                                                                 on V_DEBREG_RES_S  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEBREG_RES_S.sql =========*** End ***
PROMPT ===================================================================================== 
