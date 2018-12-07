

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OIC_ATRANSFERS_DATA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OIC_ATRANSFERS_DATA ***

create or replace view v_ow_oic_atransfers_data
(id, idn, synthcode, doc_drn, doc_orn, dk, nlsa, s, kv, nlsb, s2, kv2, nazn, inst_chain_idt, inst_plan_id, err_text, url, state)
as
select a.id, a.idn, a.anl_synthcode, a.doc_drn, a.doc_orn, w.dk,
       a.debit_anlaccount, a.debit_amount*100, a.debit_currency,
       a.credit_anlaccount, a.credit_amount*100, a.credit_currency,
       substr(a.anl_trndescr, 1, 160), a.inst_chain_idt, a.inst_plan_id, 
       a.err_text,
       make_docinput_url(case
                           when a.debit_currency = a.credit_currency then
                            'OW1'
                           else
                            'OW2'
                         end,
                         'Введення платежу',
                         'Nls_A',
                         a.debit_anlaccount,
                         'Kv_A',
                         a.debit_currency,
                         'Mfo_b',
                         a.kf,
                         'Nls_B',
                         a.credit_anlaccount,
                         'Kv_B',
                         a.credit_currency,
                         'SumC_t',
                         a.debit_amount * 100,
                         'Nazn',
                         substr(a.anl_trndescr, 1, 160),
                         'BPROC',
                         'set role bars_access_defrole@begin bars_ow.check_bpdoc('||a.id||','||a.idn||');end;',
                         'APROC',
                         'set role bars_access_defrole@begin bars_ow.set_pay_flag('||a.id||','||a.idn||',:REF, 1);end;'
                         ),
       a.state
  from ow_oic_atransfers_data a, ow_msgcode w
 where a.anl_synthcode = w.synthcode(+);

PROMPT *** Create  grants  V_OW_OIC_ATRANSFERS_DATA ***
grant SELECT                                                                 on V_OW_OIC_ATRANSFERS_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_OIC_ATRANSFERS_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_OIC_ATRANSFERS_DATA to OW;
grant SELECT                                                                 on V_OW_OIC_ATRANSFERS_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OIC_ATRANSFERS_DATA.sql =========*
PROMPT ===================================================================================== 
