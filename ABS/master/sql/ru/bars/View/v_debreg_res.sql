CREATE OR REPLACE FORCE VIEW V_DEBREG_RES
(
   REQUESTID,
   REGDATETIME,
   MFO,
   OKPO,
   NMK,
   KV,
   SUMM,
   DEBDATE,
   DEBOFFDATE,
   ADR,
   NB,
   OSN
)
AS
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
   
/   
   
   
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_DEBREG_RES TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_DEBREG_RES TO DEB_REG;
/