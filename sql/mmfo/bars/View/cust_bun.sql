

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUST_BUN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CUST_BUN ***

  CREATE OR REPLACE FORCE VIEW BARS.CUST_BUN ("ID", "RNKA", "ID_REL", "RNKB", "NAME", "BDATE", "EDATE", "DOC_TYPE", "DOC_SERIAL", "DOC_NUMBER", "DOC_DATE", "DOC_ISSUER", "BIRTHDAY", "BIRTHPLACE", "TEL", "EMAIL", "CUSTTYPE_U", "OKPO_U", "COUNTRY_U", "REGION_U", "FS_U", "VED_U", "SED_U", "ISE_U", "VAGA1", "VAGA2", "NOTES", "ADR") AS 
  select r.rel_rnk, r.rnk, r.rel_id, r.rel_rnk, c.name,
       r.bdate, r.edate, c.doc_type,
       c.doc_serial, c.doc_number, c.doc_date, c.doc_issuer,
       c.birthday, c.birthplace, c.tel, c.email,
       c.custtype, c.okpo,  c.country, c.region,
       c.fs, c.ved, c.sed, c.ise, r.vaga1, r.vaga2, c.notes, c.adr
from customer_rel r, customer_extern c
 where r.rel_id<>20 and r.rel_intext=0
   and r.rel_rnk=c.id
 union all
select r.rel_rnk, r.rnk, r.rel_id, r.rel_rnk, c.nmk,
       r.bdate, r.edate, p.passp,
       p.ser, p.numdoc, p.pdate, p.organ,
       p.bday, p.bplace,
       decode(c.custtype,3,p.teld,u.telr),
       decode(c.custtype,3,substr(w.value,1,100),u.e_mail),
       decode(c.custtype,3,2,1), c.okpo,  c.country, to_char(c.c_reg),
       c.fs, c.ved, c.sed, c.ise, r.vaga1, r.vaga2, substr(trim(m.value),1,254), c.adr
  from customer_rel r, customer c, person p, customerw w, customerw m, corps u
 where r.rel_id<>20 and r.rel_intext=1
   and r.rel_rnk=c.rnk
   and c.rnk=p.rnk(+)
   and c.rnk=w.rnk(+) and w.tag(+)='EMAIL'
   and c.rnk=m.rnk(+) and m.tag(+)='RCOMM'
   and c.rnk=u.rnk(+);

PROMPT *** Create  grants  CUST_BUN ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_BUN        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_BUN        to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_BUN        to REF0000;
grant SELECT                                                                 on CUST_BUN        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_BUN        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CUST_BUN        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUST_BUN.sql =========*** End *** =====
PROMPT ===================================================================================== 
