CREATE OR REPLACE FORCE VIEW BARS.V_DEBREG_QUERY_C
(
   REQUESTID,
   SOS,
   NMK,
   OKPO,
   QUERYTYPE,
   OSN
)
AS
         SELECT requestid,
                SOS,
                NMK,
                OKPO,
                QUERYTYPE,
                osn
           FROM DEBREG_QUERY
          WHERE PHASEID = 'C'
       ORDER BY OKPO;
/
 

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_DEBREG_QUERY_C TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_DEBREG_QUERY_C TO DEB_REG;
/