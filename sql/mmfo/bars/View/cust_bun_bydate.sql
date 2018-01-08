

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUST_BUN_BYDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view CUST_BUN_BYDATE ***

  CREATE OR REPLACE FORCE VIEW BARS.CUST_BUN_BYDATE ("ID", "RNKA", "ID_REL", "RNKB", "NAME", "BDATE", "EDATE", "TYPE_ID", "DOCUMENT_TYPE_ID", "POSITION", "DOC_TYPE", "DOC_SERIAL", "DOC_NUMBER", "DOC_DATE", "DOC_ISSUER", "BIRTHDAY", "BIRTHPLACE", "TEL", "EMAIL", "CUSTTYPE_U", "OKPO_U", "COUNTRY_U", "REGION_U", "FS_U", "VED_U", "SED_U", "ISE_U", "VAGA1", "VAGA2", "NOTES", "ADR") AS 
  select r.rel_rnk, r.rnk, r.rel_id, r.rel_rnk, c.name,
       r.bdate, r.edate, r.type_id, r.document_type_id, r.position,
       c.doc_type, c.doc_serial, c.doc_number, c.doc_date, c.doc_issuer,
       c.birthday, c.birthplace, c.tel, c.email,
       c.custtype, c.okpo, c.country, c.region,
       c.fs, c.ved, c.sed, c.ise, r.vaga1, r.vaga2, c.notes, c.adr
  from v_customer_rel_bydate r, v_customer_extern_bydate c
 where r.rel_intext = 0
   and r.rel_rnk = c.id
 union all
select r.rel_rnk, r.rnk, r.rel_id, r.rel_rnk, c.nmk,
       r.bdate, r.edate, r.type_id, r.document_type_id, r.position,
       p.passp, p.ser, p.numdoc, p.pdate, p.organ,
       p.bday, p.bplace,
       decode(c.custtype,3,p.teld,u.telr),
       decode(c.custtype,3,substr(w.value,1,100),u.e_mail),
       decode(c.custtype,3,2,1), c.okpo,  c.country, to_char(c.c_reg),
       c.fs, c.ved, c.sed, c.ise, r.vaga1, r.vaga2, substr(trim(m.value),1,254), c.adr
  from v_customer_rel_bydate r, v_customer_bydate c, person p, v_customerw_bydate w, v_customerw_bydate m, corps u
 where r.rel_intext = 1
   and r.rel_rnk = c.rnk
   and c.rnk = p.rnk(+)
   and c.rnk = w.rnk(+) and w.tag(+) = 'EMAIL'
   and c.rnk = m.rnk(+) and m.tag(+) = 'RCOMM'
   and c.rnk = u.rnk(+);

PROMPT *** Create  grants  CUST_BUN_BYDATE ***
grant SELECT                                                                 on CUST_BUN_BYDATE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_BUN_BYDATE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_BUN_BYDATE to CUST001;
grant SELECT                                                                 on CUST_BUN_BYDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUST_BUN_BYDATE.sql =========*** End **
PROMPT ===================================================================================== 
