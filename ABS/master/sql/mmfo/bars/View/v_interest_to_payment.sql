

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INTEREST_TO_PAYMENT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INTEREST_TO_PAYMENT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INTEREST_TO_PAYMENT ("ID", "ACCOUNT_ID", "INTEREST_KIND_ID", "ACCOUNT_NUMBER", "CURRENCY_ID", "OKPO", "ACCOUNT_NAME", "INTEREST_ACCOUNT_NUMBER", "DATE_FROM", "DATE_THROUGH", "INTEREST_AMOUNT", "RECEIVER_MFO", "RECEIVER_ACCOUNT", "RECEIVER_CURRENCY_ID", "PAYMENT_PURPOSE", "STATE_ID", "RECKONING_STATE", "STATE_COMMENT", "MANAGER_ID", "MANAGER_NAME", "CORPORATION_CODE", "CORPORATION_NAME") AS 
  select r.id,
       r.account_id,
       r.interest_kind_id,
       a.nls account_number,
       a.kv currency_id,
       cu.okpo,
       a.nms account_name,
       ia.nls interest_account_number,
       r.date_from,
       r.date_through,
       currency_utl.from_fractional_units(r.interest_amount, a.kv) interest_amount,
       case when i.mfob is null then a.kf else i.mfob end receiver_mfo,
       case when i.nlsb is null then a.nls else i.nlsb end receiver_account,
       case when i.kvb is null then a.kv else i.kvb end receiver_currency_id,
       case when trim(r.payment_purpose) is null then
                 interest_utl.generate_payment_purpose(r.id, r.line_type_id, i.metr, a.nls, r.date_from, r.date_through, r.interest_rate)
            else r.payment_purpose
       end payment_purpose,
       r.state_id,
       list_utl.get_item_name('INTEREST_RECKONING_STATE', r.state_id) reckoning_state,
       interest_utl.get_reckoning_comment(r.id, r.state_id, r.accrual_document_id, r.payment_document_id) state_comment,
       a.isp manager_id,
       s.fio manager_name,
       nvl(w.kodk, k.kodk) corporation_code,
       c.name_cli corporation_name
from   int_reckonings r
join   saldo a on a.acc = r.account_id
join   customer cu on cu.rnk = a.rnk
join   int_accn i on i.acc = r.account_id and i.id = r.interest_kind_id
left join saldo ia on ia.acc = i.acra
left join staff$base s on s.id = a.isp
left join rnkp_kod k on k.rnk = a.rnk
left join rnkp_kod_acc w on w.acc = a.rnk
left join kod_cli c on c.kod_cli = nvl(w.kodk, k.kodk)
where  r.grouping_line_id is null and
       r.state_id in ( 5 /*RECKONING_STATE_ACCRUED*/,
                       9 /*RECKONING_STATE_PAYMENT_FAILED*/,
                      10 /*RECKONING_STATE_PAYM_DISCARDED*/) and
       i.id = 1 -- ������
order by a.nls, r.date_from;

PROMPT *** Create  grants  V_INTEREST_TO_PAYMENT ***
grant SELECT                                                                 on V_INTEREST_TO_PAYMENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INTEREST_TO_PAYMENT.sql =========*** 
PROMPT ===================================================================================== 
