

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OIC_STRANSFERS_DATA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OIC_STRANSFERS_DATA ***

create or replace view v_ow_oic_stransfers_data
(id, idn, nlsa, s, kv, nlsb, s2, kv2, nazn, err_text, url, state)
as
select id, idn, debit_syntaccount, debit_amount*100, debit_currency,
       credit_syntaccount, credit_amount*100, credit_currency,
       substr(synth_trndescr,1,160), err_text,
       make_docinput_url(case
                           when a.debit_currency = a.credit_currency then
                            'OW1'
                           else
                            'OW2'
                         end,
                         'Введення платежу',
                         'Kv_A',
                         a.debit_currency,
                         'Mfo_b',
                         a.kf,
                         'Kv_B',
                         a.credit_currency,
                         'SumC_t',
                         a.debit_amount * 100,
                         'Nazn',
                         substr(synth_trndescr,1,160),
                         'BPROC',
                         'set role bars_access_defrole@begin bars_ow.check_bpdoc('||a.id||','||a.idn||');end;',
                         'APROC',
                         'set role bars_access_defrole@begin bars_ow.set_pay_flag('||a.id||','||a.idn||',:REF, 1);end;'
                         ),
       a.state
  from ow_oic_stransfers_data a;

PROMPT *** Create  grants  V_OW_OIC_STRANSFERS_DATA ***
grant SELECT                                                                 on V_OW_OIC_STRANSFERS_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_OIC_STRANSFERS_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_OIC_STRANSFERS_DATA to OW;
grant SELECT                                                                 on V_OW_OIC_STRANSFERS_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OIC_STRANSFERS_DATA.sql =========*
PROMPT ===================================================================================== 
