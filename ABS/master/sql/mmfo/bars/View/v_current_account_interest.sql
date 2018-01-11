

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CURRENT_ACCOUNT_INTEREST.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CURRENT_ACCOUNT_INTEREST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CURRENT_ACCOUNT_INTEREST ("ID", "ACCOUNT_ID", "CURRENCY_ID", "INTEREST_KIND_ID", "DATE_FROM", "DATE_THROUGH", "RECKONING_STATE", "ACCOUNT_REST", "INTEREST_RATE", "INTEREST_AMOUNT", "INTEREST_ACCOUNT_NUMBER", "RECEIVER_MFO", "RECEIVER_ACCOUNT", "RECEIVER_CURRENCY_ID", "PURPOSE", "RECKONING_COMMENT", "STATE_ID") AS 
  select t.id,
       t.account_id,
       a.kv currency_id,
       t.interest_kind_id,
       t.date_from,
       t.date_through,
       list_utl.get_item_name('INTEREST_RECKONING_STATE', t.state_id) reckoning_state,
       currency_utl.from_fractional_units(t.account_rest, a.kv) account_rest,
       t.interest_rate,
       currency_utl.from_fractional_units(t.interest_amount, a.kv) interest_amount,
       ia.nls interest_account_number,
       case when i.id = 1 then
                 case when i.mfob is null then a.kf else i.mfob end
            else null
       end receiver_mfo,
       case when i.id = 1 then
                 case when i.nlsb is null then a.nls else i.nlsb end
            else null
       end receiver_account,
       case when i.id = 1 then
                 case when i.kvb is null then a.kv else i.kvb end
            else null
       end receiver_currency_id,
       interest_utl.get_reckoning_purpose(t.id) purpose,
       interest_utl.get_reckoning_comment(t.id, t.state_id, t.accrual_document_id, t.payment_document_id) reckoning_comment,
       t.state_id
from   int_reckonings t
left join accounts a on a.acc = t.account_id
left join int_accn i on i.acc = a.acc and i.id = t.interest_kind_id
left join customer c on c.rnk = a.rnk
left join accounts ia on ia.acc = i.acra
left join custbank cb on cb.rnk = c.rnk
where  t.grouping_line_id is null and
       a.nbs in (select n.nbs from notportfolio_nbs n
                 where  n.portfolio_code = 'CURRENT_ACCOUNT' and
                        (n.userid = sys_context('bars_global', 'user_id') or n.userid is null)) -- and
       -- t.account_id = sys_context('bars_pul', 'account_id') and
order by t.date_from;

PROMPT *** Create  grants  V_CURRENT_ACCOUNT_INTEREST ***
grant SELECT                                                                 on V_CURRENT_ACCOUNT_INTEREST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CURRENT_ACCOUNT_INTEREST.sql ========
PROMPT ===================================================================================== 
