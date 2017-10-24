

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTARY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTARY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTARY ("ID", "TIN", "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME", "DATE_OF_BIRTH", "PASSPORT_SERIES", "PASSPORT_NUMBER", "ADDRESS", "PASSPORT_ISSUER", "PASSPORT_ISSUED", "PHONE_NUMBER", "MOBILE_PHONE_NUMBER", "EMAIL", "NOTARY_TYPE", "NOTARY_TYPE_NAME", "CERTIFICATE_NUMBER", "CERTIFICATE_ISSUE_DATE", "CERTIFICATE_CANCELATION_DATE", "CNT_ACCR", "CNT_REQACCR", "IS_APPROVED", "PASSPORT", "APPLICANT") AS 
  select a.id,
       a.tin,
       a.first_name,
       a.middle_name,
       a.last_name,
       a.date_of_birth,
       a.passport_series,
       a.passport_number,
       a.address,
       a.passport_issuer,
       a.passport_issued,
       a.phone_number,
       a.mobile_phone_number,
       a.email,
       a.notary_type,
       t.typr notary_type_name,
       a.certificate_number,
       a.certificate_issue_date,
       a.certificate_cancelation_date,
       sum(case
             when b.state_id in (0, 1) and b.close_date is null and
                  (b.expiry_date is null or b.expiry_date <= sysdate) then
              1
             else
              0
           end) cnt_accr,
       sum(case
             when b.state_id in (0) and b.close_date is null and
                  (b.expiry_date is null or b.expiry_date <= sysdate) then
              1
             else
              0
           end) cnt_reqaccr,
       case
         when (sum(case
                     when b.state_id in (1) and b.close_date is null and
                          (b.expiry_date is null or b.expiry_date <= sysdate) then
                      1
                     else
                      0
                   end)) > 0 then
          'Акредитований'
         else
          'Не акредитований'
       end is_approved,
       trim(a.passport_series || ' ' || a.passport_number) passport,
       listagg(b.account_mfo, ',') within group(order by b.account_mfo) as applicant
  from notary a, notary_accreditation b, nota_tr t
 where a.state_id = 1
   and b.notary_id(+) = a.id
   and b.state_id(+) not in (2, 3)
   and t.id(+) = a.notary_type
 group by a.id,
          a.tin,
          a.first_name,
          a.middle_name,
          a.last_name,
          a.date_of_birth,
          a.passport_series,
          a.passport_number,
          a.address,
          a.phone_number,
          a.passport_issuer,
          a.passport_issued,
          a.mobile_phone_number,
          a.email,
          a.notary_type,
          t.typr,
          a.certificate_number,
          a.certificate_issue_date,
          a.certificate_cancelation_date;

PROMPT *** Create  grants  V_NOTARY ***
grant SELECT                                                                 on V_NOTARY        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTARY.sql =========*** End *** =====
PROMPT ===================================================================================== 
