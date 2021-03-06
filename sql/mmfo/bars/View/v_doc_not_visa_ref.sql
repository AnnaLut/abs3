

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOC_NOT_VISA_REF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOC_NOT_VISA_REF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOC_NOT_VISA_REF ("BRANCH", "USERID", "FIO", "TT", "NAME_TT", "IDCHK", "PR", "NAME_CHK", "REF", "S", "VDAT") AS 
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

PROMPT *** Create  grants  V_DOC_NOT_VISA_REF ***
grant SELECT                                                                 on V_DOC_NOT_VISA_REF to BARSREADER_ROLE;
grant SELECT                                                                 on V_DOC_NOT_VISA_REF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOC_NOT_VISA_REF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOC_NOT_VISA_REF.sql =========*** End
PROMPT ===================================================================================== 
