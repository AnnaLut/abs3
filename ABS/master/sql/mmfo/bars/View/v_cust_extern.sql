

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_EXTERN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_EXTERN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_EXTERN ("RNK", "NAME", "DOC_TYPE", "DOC_NAME", "DOC_SERIAL", "DOC_NUMBER", "DOC_DATE", "DOC_ISSUER", "BIRTHDAY", "BIRTHPLACE", "SEX", "SEX_NAME", "ADR", "TEL", "EMAIL", "CUSTTYPE", "OKPO", "COUNTRY", "COUNTRY_NAME", "REGION", "FS", "FS_NAME", "VED", "VED_NAME", "SED", "SED_NAME", "ISE", "ISE_NAME", "NOTES") AS 
  select ce.id         as rnk,
       ce.name,
       ce.doc_type,
       p.name        as doc_name,
       ce.doc_serial,
       ce.doc_number,
       ce.doc_date,
       ce.doc_issuer,
       ce.birthday,
       ce.birthplace,
       ce.sex,
       sx.name       as sex_name,
       ce.adr,
       ce.tel,
       ce.email,
       ce.custtype,
       ce.okpo,
       ce.country,
       c.name        as country_name,
       ce.region,
       ce.fs,
       f.name        as fs_name,
       ce.ved,
       v.name        as ved_name,
       ce.sed,
       s.name        as sed_name,
       ce.ise,
       i.name        as ise_name,
       ce.notes
  from customer_extern ce,
       country         c,
       fs              f,
       ise             i,
       passp           p,
       sed             s,
       sex             sx,
       ved             v
 where ce.doc_type = p.passp(+)
   and ce.sex = sx.id(+)
   and ce.country = c.country(+)
   and ce.fs = f.fs(+)
   and ce.ved = v.ved(+)
   and ce.sed = s.sed(+)
   and ce.ise = i.ise(+)
 order by ce.id;

PROMPT *** Create  grants  V_CUST_EXTERN ***
grant SELECT                                                                 on V_CUST_EXTERN   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUST_EXTERN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_EXTERN   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_EXTERN.sql =========*** End *** 
PROMPT ===================================================================================== 
