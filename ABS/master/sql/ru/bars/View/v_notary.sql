

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTARY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTARY ***

CREATE OR REPLACE FORCE VIEW BARS.V_NOTARY AS 
SELECT a.ID,
       a.TIN,
       a.FIRST_NAME,
       a.MIDDLE_NAME,
       a.LAST_NAME,
       a.DATE_OF_BIRTH,
       a.PASSPORT_SERIES,
       a.PASSPORT_NUMBER,
       a.ADDRESS,
       a.PASSPORT_ISSUER,
       a.PASSPORT_ISSUED,
       a.PHONE_NUMBER,
       a.MOBILE_PHONE_NUMBER,
       a.EMAIL,
       a.NOTARY_TYPE,
       t.typr NOTARY_TYPE_NAME,
       a.CERTIFICATE_NUMBER,
       a.CERTIFICATE_ISSUE_DATE,
       a.CERTIFICATE_CANCELATION_DATE,
       trim(a.passport_series || ' ' || a.passport_number) passport,
       case when na.state_id in (0, 1) and na.close_date is null and (na.expiry_date is null or na.expiry_date <= sysdate) then 1 else 0 end as cnt_accr,
       case when na.state_id in (0)    and na.close_date is null and (na.expiry_date is null or na.expiry_date <= sysdate) then 1 else 0 end as cnt_reqaccr,
       case when na.state_id in (1)    and na.close_date is null and (na.expiry_date is null or na.expiry_date <= sysdate) then 'Акредитований' else 'Не акредитований' end as is_approved,
       ta.typa as ACCREDITATION_TYPE,
       Nota.Get_Accr_Branches(na.id) as Accr_Branches,
       Nota.Get_Accr_BranchNames(na.id) as Accr_BranchNames,
       Nota.Get_Accr_Seg_of_Business(na.id) as Accr_Seg_of_Business,
       a.document_type,
       a.idcard_document_number,
       a.idcard_notation_number,
       a.passport_expiry
    from NOTARY a
    left outer join NOTARY_ACCREDITATION na on a.id = na.notary_id and na.state_id not in (2, 3)
    left outer join nota_ta ta on na.ACCREDITATION_TYPE_ID = ta.id
    left outer join NOTA_TR t on a.NOTARY_TYPE = t.id
   WHERE a.state_id = 1;
		 
PROMPT *** Create  grants  V_NOTARY ***

grant SELECT                                                                 on V_NOTARY        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NOTARY        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTARY.sql =========*** End *** =====
PROMPT ===================================================================================== 
