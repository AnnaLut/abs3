

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INTEREST_TO_ACCRUAL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INTEREST_TO_ACCRUAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INTEREST_TO_ACCRUAL ("ID", "ACCOUNT_ID", "INTEREST_KIND_ID", "ACCOUNT_NUMBER", "CURRENCY_ID", "OKPO", "ACCOUNT_NAME", "INTEREST_KIND_NAME", "INTEREST_ACCOUNT_NUMBER", "DATE_FROM", "DATE_THROUGH", "ACCOUNT_REST", "INTEREST_RATE", "INTEREST_AMOUNT", "COUNTER_ACCOUNT", "ACCRUAL_PURPOSE", "STATE_ID", "RECKONING_STATE", "STATE_COMMENT", "MANAGER_ID", "MANAGER_NAME", "CORPORATION_CODE", "CORPORATION_NAME") AS 
  select r.id,
       r.account_id,
       r.interest_kind_id,
       a.nls account_number,
       a.kv currency_id,
       cu.okpo,
       a.nms account_name,
       ik.name interest_kind_name,
       ia.nls interest_account_number,
       r.date_from,
       r.date_through,
       currency_utl.from_fractional_units(r.account_rest, a.kv) account_rest,
       r.interest_rate,
       currency_utl.from_fractional_units(r.interest_amount, a.kv) interest_amount,
       ca.nls counter_account,
       case when r.state_id in (1 /*RECKONING_STATE_RECKONED*/,
                                2 /*RECKONING_STATE_MODIFIED*/,
                                6 /*RECKONING_STATE_ACCRUAL_FAILED*/) then
                 case when r.accrual_purpose is null then
                           interest_utl.generate_accrual_purpose(r.id, r.line_type_id, i.metr, a.nls, r.date_from, r.date_through, r.interest_rate)
                      else r.accrual_purpose
                 end
            else ''
       end accrual_purpose,
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
join   int_idn ik on ik.id = i.id
left join saldo ia on ia.acc = i.acra
left join accounts ca on ca.acc = i.acrb
left join rnkp_kod k on k.rnk = a.rnk
left join rnkp_kod_acc w on w.acc = a.rnk
left join kod_cli c on c.kod_cli = nvl(w.kodk, k.kodk)
left join staff$base s on s.id = a.isp
where  r.grouping_line_id is null and
       (r.state_id in (1 /*RECKONING_STATE_RECKONED*/,
                       2 /*RECKONING_STATE_MODIFIED*/,
                       3 /*RECKONING_STATE_RECKONING_FAIL*/,
                       6 /*RECKONING_STATE_ACCRUAL_FAILED*/) or
        (r.state_id = 99 /*RECKONING_STATE_ONLY_INFO*/ and pul.get('SHOW_ZERO_RECKONINGS') = 'Y'))
order by a.nls, r.date_from;

PROMPT *** Create  grants  V_INTEREST_TO_ACCRUAL ***
grant SELECT                                                                 on V_INTEREST_TO_ACCRUAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INTEREST_TO_ACCRUAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INTEREST_TO_ACCRUAL.sql =========*** 
PROMPT ===================================================================================== 
