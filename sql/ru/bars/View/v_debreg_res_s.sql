CREATE OR REPLACE FORCE VIEW BARS.V_DEBREG_RES_S
(
   REQUESTID,
   OKPO,
   NMK,
   ADR,
   CUSTTYPE,
   REZID,
   EVENTTYPE,
   EVENTDATE,
   DEBNUM,
   KV,
   CRDAGRNUM,
   CRDDATE,
   SUMM,
   DEBDATE,
   REGDATETIME,
   FILENAME,
   OSN
)
AS
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
   
   
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_DEBREG_RES_S TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_DEBREG_RES_S TO DEB_REG;
/