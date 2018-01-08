

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_ESK_DATA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_ESK_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_ESK_DATA ("ID", "IDN", "ND", "RNK", "NLS", "OKPO", "FIRST_NAME", "LAST_NAME", "MIDDLE_NAME", "TYPE_DOC", "PASPSERIES", "PASPNUM", "PASPISSUER", "PASPDATE", "BDAY", "COUNTRY", "RESIDENT", "GENDER", "ENG_FIRST_NAME", "ENG_LAST_NAME", "MNAME", "ADDR1_DOMAIN", "ADDR1_REGION", "ADDR1_CITYNAME", "ADDR1_STREET", "WORK", "OFFICE", "DATE_W", "TABN", "STR_ERR") AS 
  select i.id, i.idn, i.nd, i.rnk, a.nls,
       i.okpo, i.first_name, i.last_name, i.middle_name,
       i.type_doc, i.paspseries, i.paspnum, i.paspissuer, i.paspdate, i.bday,
       i.country, i.resident, i.gender,
       i.eng_first_name, i.eng_last_name, i.mname,
       i.addr1_domain, i.addr1_region, i.addr1_cityname, i.addr1_street,
       i.work, i.office, i.date_w, i.tabn, i.str_err
  from ow_salary_data i, w4_acc o, accounts a
 where i.nd = o.nd(+)
   and o.acc_pk = a.acc(+);

PROMPT *** Create  grants  V_OW_ESK_DATA ***
grant SELECT                                                                 on V_OW_ESK_DATA   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_ESK_DATA   to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_ESK_DATA.sql =========*** End *** 
PROMPT ===================================================================================== 
