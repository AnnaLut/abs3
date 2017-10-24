CREATE OR REPLACE FORCE VIEW BARS.V_DOC_NOT_VISA_REF
(
   BRANCH,
   USERID,
   FIO,
   TT,
   NAME_TT,
   IDCHK,
   PR,
   NAME_CHK,
   REF,
   S,
   VDAT
)
AS
     SELECT oper.BRANCH,
            oper.userid,
            s.fio,
            t.tt,
            t.name name_tt,
            n.idchk,
            NVL (LENGTH (TRIM (oper.chk)), 0) / 6 + 1 pr,
            n.name name_chk,
            OPER.REF,
            oper.s/ 100 s,
            oper.vdat
       FROM ref_que q,
            oper,
            tts t,
            chklist n,
            staff s
      WHERE     oper.tt = t.tt
            AND s.id = oper.userid
            AND n.idchk = hex_to_num (oper.nextvisagrp)
            AND oper.sos <> 5
            AND oper.sos >= 0
            AND oper.REF = q.REF
   ORDER BY 1,
            n.idchk,
            t.tt,
            oper.userid;


GRANT SELECT ON BARS.V_DOC_NOT_VISA_REF TO BARS_ACCESS_DEFROLE;