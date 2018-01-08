

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OIC_DOCUMENTS_DATA.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OIC_DOCUMENTS_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_OIC_DOCUMENTS_DATA ("ID", "IDN", "NLSA", "KV", "S", "MFOB", "ID_B", "NAM_B", "NLSB", "KV2", "S2", "NAZN", "ERR_TEXT", "URL") AS 
  select id, idn, org_cbsnumber nlsa, bill_currency kv, bill_amount * 100 s,
       dest_institution mfob, cnt_clientregnumber id_b,
       substr(cnt_clientname, 1, 38) nam_b, cnt_contractnumber nlsb,
       bill_currency kv2, bill_amount * 100 s2,
       substr(nvl(doc_socmnt, doc_descr), 1, 160) nazn, err_text,
       make_docinput_url(case
                           when dest_institution = kf then
                            case
                              when work_flag = 0 then
                               'OW5'
                              else
                               case
                                 when cnt_contractnumber like '2605%' and
                                      (select count(*)
                                         from accounts
                                        where nls = cnt_contractnumber and kv = bill_currency and
                                              (tip like 'PK%' or tip like 'W4%')) > 0 then
                                  'PKR'
                                 else
                                  'OW1'
                               end
                            end
                           else
                            case
                              when work_flag = 0 then
                               'OW6'
                              else
                               'OW3'
                            end
                         end,
                         '¬веденн€ платежу',
                         'Kv_A',
                         bill_currency,
                         'Mfo_b',
                         dest_institution,
                         'Kv_B',
                         bill_currency,
                         'Nls_B',
                         cnt_contractnumber,
                         'Id_B',
                         cnt_clientregnumber,
                         'SumC_t',
                         bill_amount * 100,
                         'Nazn',
                         substr(nvl(doc_socmnt, doc_descr), 1, 160),
                         'BPROC',
                         'set role bars_access_defrole@begin bars_ow.check_bpdoc('||id||','||idn||');end;',
                         'APROC',
                         'set role bars_access_defrole@begin bars_ow.set_pay_flag('||id||','||idn||',:REF, 1);end;'
                         ) as url
  from ow_oic_documents_data;

PROMPT *** Create  grants  V_OW_OIC_DOCUMENTS_DATA ***
grant SELECT                                                                 on V_OW_OIC_DOCUMENTS_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_OIC_DOCUMENTS_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_OIC_DOCUMENTS_DATA to OW;
grant SELECT                                                                 on V_OW_OIC_DOCUMENTS_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OIC_DOCUMENTS_DATA.sql =========**
PROMPT ===================================================================================== 
