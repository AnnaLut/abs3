

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TRUSTEE.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view TRUSTEE ***

  CREATE OR REPLACE FORCE VIEW BARS.TRUSTEE ("ID", "RNK", "FIO", "BDATE", "EDATE", "DOCUMENT", "NOTARY_NAME", "NOTARY_REGION", "TRUST_REGNUM", "TRUST_REGDAT", "OKPO", "DOC_TYPE", "DOC_SERIAL", "DOC_NUMBER", "DOC_DATE", "DOC_ISSUER", "BIRTHDAY", "BIRTHPLACE", "TYPE_ID", "DOCUMENT_TYPE_ID", "POSITION", "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME", "SEX", "TEL", "SIGN_PRIVS", "NAME_R", "SIGN_ID", "ADR") AS 
  select r.rel_rnk, r.rnk, c.name, r.bdate, r.edate, r.document,
       r.notary_name, r.notary_region, r.trust_regnum, r.trust_regdat,
       c.okpo, c.doc_type, c.doc_serial, c.doc_number, c.doc_date, c.doc_issuer,
       c.birthday, c.birthplace, r.type_id, r.document_type_id, r.position,
       r.first_name, r.middle_name, r.last_name, c.sex, c.tel,
       r.sign_privs, r.name_r, r.sign_id, c.adr
  from customer_rel r, customer_extern c
 where r.rel_id=20 and r.rel_intext=0
   and r.rel_rnk=c.id
 union all
select r.rel_rnk, r.rnk, c.nmk, r.bdate, r.edate, r.document,
       r.notary_name, r.notary_region, r.trust_regnum, r.trust_regdat,
       c.okpo, p.passp, p.ser, p.numdoc, p.pdate, p.organ,
       p.bday, p.bplace, r.type_id, r.document_type_id, r.position,
       r.first_name, r.middle_name, r.last_name, p.sex, p.teld,
       r.sign_privs, r.name_r, r.sign_id, c.adr
  from customer_rel r, customer c, person p
 where r.rel_id=20 and r.rel_intext=1
   and r.rel_rnk=c.rnk and c.rnk=p.rnk;

PROMPT *** Create  grants  TRUSTEE ***
grant SELECT                                                                 on TRUSTEE         to BARSREADER_ROLE;
grant SELECT                                                                 on TRUSTEE         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TRUSTEE         to CUST001;
grant SELECT                                                                 on TRUSTEE         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TRUSTEE         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TRUSTEE.sql =========*** End *** ======
PROMPT ===================================================================================== 
