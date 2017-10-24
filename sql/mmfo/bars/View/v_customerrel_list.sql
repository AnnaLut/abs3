

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMERREL_LIST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMERREL_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMERREL_LIST ("RNK", "INTEXT", "CUSTTYPE", "NMK", "OKPO", "ADR", "COUNTRY", "REGION", "VED", "SED", "ISE", "DOC_TYPE", "DOC_SERIAL", "DOC_NUMBER", "DOC_DATE", "DOC_ISSUER", "BIRTHDAY", "BIRTHPLACE", "SEX", "TEL", "EMAIL", "NOTES") AS 
  select c.rnk, 1 intext, 2 custtype, c.nmk, c.okpo, c.adr, c.country, to_char(c.c_reg),
       c.ved, c.sed, c.ise,
       p.passp, p.ser, p.numdoc, p.pdate, p.organ, p.bday, p.bplace,
       nvl(p.sex,0), p.teld tel,
       (select substr(trim(value),1,254) from customerw where rnk = c.rnk and tag = 'EMAIL') email,
       (select substr(trim(value),1,254) from customerw where rnk = c.rnk and tag = 'RCOMM') comm
  from customer c, person p
 where c.custtype = 3 and nvl(trim(c.sed),'00') <> 91
   and c.rnk = p.rnk
 union all
select c.rnk, 1 intext, 1 custtype, c.nmk, c.okpo, c.adr, c.country, to_char(c.c_reg),
       c.ved, c.sed, c.ise,
       null passp, null ser, null numdoc, null pdate, null organ, null bday, null bplace,
       null sex, s.telr tel, s.e_mail email,
       (select substr(trim(value),1,254) from customerw where rnk = c.rnk and tag = 'RCOMM') comm
  from customer c, corps s
 where c.custtype = 2
   and c.rnk = s.rnk
 union all
select c.id rnk, 0 intext, c.custtype, c.name, c.okpo, c.adr, c.country, c.region,
       c.ved, c.sed, c.ise,
       c.doc_type, c.doc_serial, c.doc_number,
       c.doc_date, c.doc_issuer, c.birthday, c.birthplace,
       c.sex, c.tel, c.email, c.notes
  from customer_extern c  ;

PROMPT *** Create  grants  V_CUSTOMERREL_LIST ***
grant SELECT                                                                 on V_CUSTOMERREL_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMERREL_LIST to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMERREL_LIST.sql =========*** End
PROMPT ===================================================================================== 
