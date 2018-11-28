
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_opers.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_OPERS ("ID", "OPER_DT", "DBT", "CRD", "AMOUNT", "STATE", "DOC_REF", "CUR_CODE", "PURPOSE", "MFO", "MESSAGE", "USER_REF", "LAST_DT", "VDAT", "KF", "BRANCH") AS 
  select o."ID",o."OPER_DT",o."DBT",o."CRD",o."AMOUNT",o."STATE",o."DOC_REF",o."CUR_CODE",o."PURPOSE",o."MFO",o."MESSAGE",o."USER_REF",o."LAST_DT", op.vdat, op.kf, op.branch
  from opers o, bars.oper op
  where o.doc_ref = op.ref(+)
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_opers.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 