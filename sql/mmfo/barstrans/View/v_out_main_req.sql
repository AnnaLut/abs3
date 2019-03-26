CREATE OR REPLACE FORCE VIEW BARSTRANS.V_OUT_MAIN_REQ
(
   ID,
   SEND_TYPE,
   INS_DATE,
   STATUS,
   DONE_DATE,
   USER_ID,
   USER_KF
)
AS
   SELECT R.ID,
          R.SEND_TYPE,
          R.INS_DATE,
          S.NAME AS STATUS,
          R.DONE_DATE,
          R.USER_ID,
          USER_KF
     FROM OUT_MAIN_REQ R LEFT JOIN OUT_STATE S ON R.STATUS = S.ID;
/
GRANT SELECT ON BARSTRANS.V_OUT_MAIN_REQ TO BARS;
/