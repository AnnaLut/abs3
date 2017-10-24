CREATE OR REPLACE FORCE VIEW BARS.V_ZAG_PF
(
   FN,
   DAT,
   N,
   OTM,
   DATK
)
AS
   SELECT FN,
          DAT,
          N,
          OTM,
          DATK
     FROM ZAG_PF;
/



GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_ZAG_PF TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_ZAG_PF TO DEB_REG;
/