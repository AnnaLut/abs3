PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VV_P_SEC_AUDIT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view VV_P_SEC_AUDIT ***

CREATE OR REPLACE VIEW VV_P_SEC_AUDIT AS
SELECT rec_date as datte, rec_message as mes, rec_uid as userid
   FROM bars.sec_audit where rec_date>sysdate-2;


PROMPT *** Create  grants  VV_P_SEC_AUDIT ***
grant SELECT                                                                 on VV_P_SEC_AUDIT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VV_P_SEC_AUDIT to BARSR;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VV_P_SEC_AUDIT.sql =========**
PROMPT ===================================================================================== 
