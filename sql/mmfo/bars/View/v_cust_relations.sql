

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_RELATIONS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_RELATIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_RELATIONS ("RNK", "REL_INTEXT", "RELEXT_ID", "RELCUST_RNK", "NAME", "DOC_TYPE", "DOC_NAME", "DOC_SERIAL", "DOC_NUMBER", "DOC_DATE", "DOC_ISSUER", "BIRTHDAY", "BIRTHPLACE", "SEX", "SEX_NAME", "ADR", "TEL", "EMAIL", "CUSTTYPE", "OKPO", "COUNTRY", "COUNTRY_NAME", "REGION", "FS", "FS_NAME", "VED", "VED_NAME", "SED", "SED_NAME", "ISE", "ISE_NAME", "NOTES") AS 
  select cr.rnk,
       cr.rel_intext,
       decode(cr.rel_intext, 0, cd.relcust_code, null) as relext_id,
       decode(cr.rel_intext, 1, cd.relcust_code, null) as relcust_rnk,
       cd.name,
       cd.doc_type,
       p.name        as doc_name,
       cd.doc_serial,
       cd.doc_number,
       cd.doc_date,
       cd.doc_issuer,
       cd.birthday,
       cd.birthplace,
       cd.sex,
       sx.name       as sex_name,
       cd.adr,
       cd.tel,
       cd.email,
       cd.custtype,
       cd.okpo,
       cd.country,
       c.name        as country_name,
       cd.region,
       cd.fs,
       f.name        as fs_name,
       cd.ved,
       v.name        as ved_name,
       cd.sed,
       s.name        as sed_name,
       cd.ise,
       i.name        as ise_name,
       cd.notes
  from (select rnk, rel_intext, rel_rnk
          from customer_rel
         group by rnk, rel_intext, rel_rnk) cr,
       (select ce.id as relcust_code,
               'CE' as src,
               ce.name,
               ce.doc_type,
               ce.doc_serial,
               ce.doc_number,
               ce.doc_date,
               ce.doc_issuer,
               ce.birthday,
               ce.birthplace,
               ce.sex,
               ce.adr,
               ce.tel,
               ce.email,
               ce.custtype,
               ce.okpo,
               ce.country,
               ce.region,
               ce.fs,
               ce.ved,
               ce.sed,
               ce.ise,
               ce.notes
          from customer_extern ce
        union all
        select c.rnk as relcust_code,
               'C' as src,
               c.nmk as name,
               p.passp as doc_type,
               p.ser as doc_serial,
               p.numdoc as doc_number,
               p.pdate as doc_date,
               p.organ as doc_issuer,
               p.bday as birthday,
               p.bplace as birthplace,
               nvl(p.sex, 0) as sex,
               c.adr,
               p.teld as tel,
               f_get_custw_h(c.rnk, 'EMAIL', sysdate) as email,
               2 as custtype,
               c.okpo,
               c.country,
               to_char(c.c_reg) as region,
               c.fs,
               c.ved,
               c.sed,
               c.ise,
               f_get_custw_h(c.rnk, 'RCOMM', sysdate) as notes
          from customer c, person p
         where c.custtype = 3
           and c.rnk = p.rnk(+)
        union all
        select c.rnk as relcust_code,
               'C' as src,
               c.nmk as name,
               null as doc_type,
               null as doc_serial,
               null as doc_number,
               null as doc_date,
               null as doc_issuer,
               null as birthday,
               null as birthplace,
               null as sex,
               c.adr,
               cp.telr as tel,
               cp.e_mail as email,
               1 as custtype,
               c.okpo,
               c.country,
               to_char(c.c_reg) as region,
               c.fs,
               c.ved,
               c.sed,
               c.ise,
               f_get_custw_h(c.rnk, 'RCOMM', sysdate) as notes
          from customer c, corps cp
         where c.custtype = 2
           and c.rnk = cp.rnk(+)
        union all
        select c.rnk as relcust_code,
               'C' as src,
               c.nmk as name,
               null as doc_type,
               null as doc_serial,
               null as doc_number,
               null as doc_date,
               null as doc_issuer,
               null as birthday,
               null as birthplace,
               null as sex,
               c.adr,
               cb.telr as tel,
               null as email,
               1 as custtype,
               c.okpo,
               c.country,
               to_char(c.c_reg) as region,
               c.fs,
               c.ved,
               c.sed,
               c.ise,
               f_get_custw_h(c.rnk, 'RCOMM', sysdate) as notes
          from customer c, custbank cb
         where c.custtype = 1
           and c.rnk = cb.rnk(+)
       ) cd,
       country c,
       fs f,
       ise i,
       passp p,
       sed s,
       sex sx,
       ved v
 where decode(cr.rel_intext, 0, 'CE', 1, 'C') = cd.src
   and cr.rel_rnk = cd.relcust_code
   and cd.doc_type = p.passp(+)
   and cd.sex = sx.id(+)
   and cd.country = c.country(+)
   and cd.fs = f.fs(+)
   and cd.ved = v.ved(+)
   and cd.sed = s.sed(+)
   and cd.ise = i.ise(+)
 order by cr.rnk, cr.rel_intext, cr.rel_rnk;

PROMPT *** Create  grants  V_CUST_RELATIONS ***
grant SELECT                                                                 on V_CUST_RELATIONS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUST_RELATIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_RELATIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_RELATIONS.sql =========*** End *
PROMPT ===================================================================================== 
