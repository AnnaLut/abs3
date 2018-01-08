

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_REL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_REL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_REL ("RNK", "REL_ID", "REL_RNK", "REL_INTEXT", "NAME", "DOC_TYPE", "DOC_SERIAL", "DOC_NUMBER", "DOC_DATE", "DOC_ISSUER", "BIRTHDAY", "BIRTHPLACE", "SEX", "ADR", "TEL", "EMAIL", "CUSTTYPE", "OKPO", "COUNTRY", "REGION", "FS", "VED", "SED", "ISE", "NOTES", "VAGA1", "VAGA2", "TYPE_ID", "POSITION", "POSITION_R", "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME", "DOCUMENT_TYPE_ID", "DOCUMENT", "TRUST_REGNUM", "TRUST_REGDAT", "BDATE", "EDATE", "NOTARY_NAME", "NOTARY_REGION", "SIGN_PRIVS", "SIGN_ID", "NAME_R") AS 
  select rnk, rel_id, rel_rnk, rel_intext, name,
       doc_type, doc_serial, doc_number, doc_date, doc_issuer,
       birthday, birthplace, sex, adr, tel, email,
       custtype, okpo, country, region, fs, ved, sed, ise, notes,
       vaga1, vaga2,
       type_id, position, position_r, first_name, middle_name, last_name,
       document_type_id, document, trust_regnum, trust_regdat,
       bdate, edate, notary_name, notary_region,
       sign_privs, sign_id, name_r
  from ( select r.rnk, r.rel_id, c.id rel_rnk, r.rel_intext, c.name,
                c.doc_type, c.doc_serial, c.doc_number,
                c.doc_date, c.doc_issuer, c.birthday, c.birthplace,
                c.sex, c.adr, c.tel, c.email,
                c.custtype, c.okpo, c.country, c.region,
                c.fs, c.ved, c.sed, c.ise, c.notes,
                r.vaga1, r.vaga2,
                r.type_id, r.position, r.position_r, r.first_name, r.middle_name, r.last_name,
                r.document_type_id, r.document,
                r.trust_regnum, r.trust_regdat, r.bdate, r.edate,
                r.notary_name, r.notary_region,
                r.sign_privs, r.sign_id, r.name_r
           from customer_rel r, customer_extern c
          where r.rel_intext=0 and r.rel_rnk=c.id
          union all
         select r.rnk, r.rel_id, c.rnk, r.rel_intext, c.nmk, p.passp, p.ser, p.numdoc,
                p.pdate, p.organ, p.bday, p.bplace,
                nvl(p.sex,0), c.adr,
                decode(c.custtype,3,p.teld,s.telr),
                decode(c.custtype,3,substr(trim(w.value),1,254),s.e_mail),
                decode(c.custtype,3,2,1), c.okpo, c.country, to_char(c.c_reg),
                c.fs, c.ved, c.sed, c.ise, substr(trim(m.value),1,254),
                r.vaga1, r.vaga2,
                r.type_id, r.position, r.position_r, r.first_name, r.middle_name, r.last_name,
                r.document_type_id, r.document,
                r.trust_regnum, r.trust_regdat, r.bdate, r.edate,
                r.notary_name, r.notary_region,
                r.sign_privs, r.sign_id, r.name_r
           from customer_rel r, customer c, person p, customerw w, customerw m, corps s
          where r.rel_intext=1 and r.rel_rnk=c.rnk
            and c.rnk=p.rnk(+)
            and r.rnk=w.rnk(+) and w.tag(+)='EMAIL'
            and c.rnk=m.rnk(+) and m.tag(+)='RCOMM'
            and c.rnk=s.rnk(+) ) ;

PROMPT *** Create  grants  V_CUSTOMER_REL ***
grant SELECT                                                                 on V_CUSTOMER_REL  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_REL  to BARSUPL;
grant SELECT                                                                 on V_CUSTOMER_REL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_REL  to BARS_DM;
grant SELECT                                                                 on V_CUSTOMER_REL  to CUST001;
grant SELECT                                                                 on V_CUSTOMER_REL  to STO;
grant SELECT                                                                 on V_CUSTOMER_REL  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CUSTOMER_REL  to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_CUSTOMER_REL  to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_REL.sql =========*** End ***
PROMPT ===================================================================================== 
