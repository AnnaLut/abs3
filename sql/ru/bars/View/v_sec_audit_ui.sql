

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SEC_AUDIT_UI.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SEC_AUDIT_UI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SEC_AUDIT_UI ("REC_ID", "REC_UID", "REC_UNAME", "REC_UPROXY", "REC_DATE", "REC_BDATE", "REC_TYPE", "REC_MODULE", "REC_MESSAGE", "MACHINE", "REC_OBJECT", "REC_USERID", "BRANCH", "REC_STACK", "CLIENT_IDENTIFIER", "SEC_TYPECOMM") AS 
  select a."REC_ID",a."REC_UID",a."REC_UNAME",a."REC_UPROXY",a."REC_DATE",a."REC_BDATE",a."REC_TYPE",a."REC_MODULE",a."REC_MESSAGE",a."MACHINE",a."REC_OBJECT",a."REC_USERID",a."BRANCH",a."REC_STACK",a."CLIENT_IDENTIFIER",
       T.SEC_TYPECOMM
from sec_audit a,
     SEC_RECTYPE t
where rec_date > sysdate - 1/48
    and (  rec_type = 'INFO'
        or rec_type = 'ERROR'
        or rec_type = 'WARNING'
        or rec_type = 'FINANCIAL'
        or rec_type = 'SECURITY')
    and rec_uid = BARS.USER_ID
    and A.REC_TYPE = t.sec_rectype
order by rec_id desc;

PROMPT *** Create  grants  V_SEC_AUDIT_UI ***
grant SELECT                                                                 on V_SEC_AUDIT_UI  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SEC_AUDIT_UI.sql =========*** End ***
PROMPT ===================================================================================== 
