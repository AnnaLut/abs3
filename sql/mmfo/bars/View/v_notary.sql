

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTARY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTARY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTARY ("ID", "TIN", "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME", "DATE_OF_BIRTH", "PASSPORT_SERIES", "PASSPORT_NUMBER", "ADDRESS", "PASSPORT_ISSUER", "PASSPORT_ISSUED", "PHONE_NUMBER", "MOBILE_PHONE_NUMBER", "EMAIL", "NOTARY_TYPE", "NOTARY_TYPE_NAME", "CERTIFICATE_NUMBER", "CERTIFICATE_ISSUE_DATE", "CERTIFICATE_CANCELATION_DATE", "CNT_ACCR", "CNT_REQACCR", "IS_APPROVED", "PASSPORT") AS 
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
       sum (case when b.state_id in (0, 1) and b.close_date is null and (b.expiry_date is null or b.expiry_date <= sysdate) then 1 else 0 end) cnt_accr,
       sum (case when b.state_id in (0) and b.close_date is null and (b.expiry_date is null or b.expiry_date <= sysdate) then 1 else 0 end) cnt_reqaccr,
       case when (sum(case when b.state_id in (1) and
                                b.close_date is null and
                                (b.expiry_date is null or b.expiry_date <= sysdate) then 1
                            else 0
                      end)) > 0 then 'Акредитований' else 'Не акредитований' end is_approved,
       trim(a.passport_series || ' ' || a.passport_number) passport
FROM   NOTARY a, NOTARY_ACCREDITATION b, NOTA_TR t
WHERE  a.state_id = 1 /*nota.NOTARY_STATE_ACTIVE*/ and
       b.notary_id(+) = a.id
       AND b.state_id(+) NOT IN (2, 3)
       AND t.id(+) = a.NOTARY_TYPE
GROUP BY a.ID,
         a.TIN,
         a.FIRST_NAME,
         a.MIDDLE_NAME,
         a.LAST_NAME,
         a.DATE_OF_BIRTH,
         a.PASSPORT_SERIES,
         a.PASSPORT_NUMBER,
         a.ADDRESS,
         a.PHONE_NUMBER,
         a.PASSPORT_ISSUER,
         a.PASSPORT_ISSUED,
         a.MOBILE_PHONE_NUMBER,
         a.EMAIL,
         a.NOTARY_TYPE,
         t.typr,
         a.CERTIFICATE_NUMBER,
         a.CERTIFICATE_ISSUE_DATE,
         a.CERTIFICATE_CANCELATION_DATE;

PROMPT *** Create  grants  V_NOTARY ***
grant SELECT                                                                 on V_NOTARY        to BARSREADER_ROLE;
grant SELECT                                                                 on V_NOTARY        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NOTARY        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTARY.sql =========*** End *** =====
PROMPT ===================================================================================== 
