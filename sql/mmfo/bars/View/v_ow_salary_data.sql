

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_SALARY_DATA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_SALARY_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_SALARY_DATA ("ID", "IDN", "ND", "RNK", "NLS", "OKPO", "FIRST_NAME", "LAST_NAME", "MIDDLE_NAME", "TYPE_DOC", "PASPSERIES", "PASPNUM", "PASPISSUER", "PASPDATE", "BDAY", "COUNTRY", "RESIDENT", "GENDER", "PHONE_HOME", "PHONE_MOB", "EMAIL", "ENG_FIRST_NAME", "ENG_LAST_NAME", "MNAME", "ADDR1_CITYNAME", "ADDR1_PCODE", "ADDR1_DOMAIN", "ADDR1_REGION", "ADDR1_STREET", "ADDR2_CITYNAME", "ADDR2_PCODE", "ADDR2_DOMAIN", "ADDR2_REGION", "ADDR2_STREET", "WORK", "OFFICE", "DATE_W", "OKPO_W", "PERS_CAT", "AVER_SUM", "TABN", "STR_ERR", "FLAG_OPEN", "KK_SECRET_WORD", "KK_REGTYPE", "KK_CITYAREAID", "KK_STREETTYPEID", "KK_STREETNAME", "KK_APARTMENT", "KK_POSTCODE", "KK_PHOTO_DATA") AS 
  select i.id, i.idn, i.nd, i.rnk, a.nls,
       i.okpo, i.first_name, i.last_name, i.middle_name,
       i.type_doc, i.paspseries, i.paspnum, i.paspissuer, i.paspdate, i.bday,
       i.country, i.resident, i.gender, i.phone_home, i.phone_mob, i.email,
       i.eng_first_name, i.eng_last_name, i.mname,
       i.addr1_cityname, i.addr1_pcode, i.addr1_domain, i.addr1_region, i.addr1_street,
       i.addr2_cityname, i.addr2_pcode, i.addr2_domain, i.addr2_region, i.addr2_street,
       i.work, i.office, i.date_w, i.okpo_w, i.pers_cat, i.aver_sum, i.tabn, i.str_err, i.flag_open,
       i.kk_secret_word, i.kk_regtype, i.kk_cityareaid, i.kk_streettypeid, i.kk_streetname,
       i.kk_apartment, i.kk_postcode, i.kk_photo_data
  from ow_salary_data i, w4_acc o, accounts a
 where i.nd = o.nd(+)
   and o.acc_pk = a.acc(+);

PROMPT *** Create  grants  V_OW_SALARY_DATA ***
grant SELECT                                                                 on V_OW_SALARY_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_SALARY_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_SALARY_DATA to OW;
grant SELECT                                                                 on V_OW_SALARY_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_SALARY_DATA.sql =========*** End *
PROMPT ===================================================================================== 
