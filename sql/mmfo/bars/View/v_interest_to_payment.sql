create or replace view v_interest_to_payment as
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
                 interest_utl.generate_payment_purpose(r.id, i.metr, a.nls, r.date_from, r.date_through, r.interest_rate, r.is_grouping_unit)
            else r.payment_purpose
       end payment_purpose,
       r.state_id,
       list_utl.get_item_name('INTEREST_RECKONING_STATE', r.state_id) reckoning_state,
       interest_utl.get_reckoning_comment(r.id, r.state_id, r.accrual_document_id, r.payment_document_id) state_comment,
       a.isp manager_id,
       s.fio manager_name,
       nvl(acorp.value, ccorp.value) corporation_code,
       nvl(aname.corporation_name, cname.corporation_name) corporation_name
from   int_reckonings r
join   saldo a on a.acc = r.account_id
join   customer cu on cu.rnk = a.rnk
join   int_accn i on i.acc = r.account_id and i.id = r.interest_kind_id
left join saldo ia on ia.acc = i.acra
left join staff$base s on s.id = a.isp
left join accountsw acorp on acorp.acc = a.acc and acorp.tag = 'OBCORP'
left join customerw ccorp on ccorp.rnk = a.rnk and ccorp.TAG = 'OBPCP' 
left join v_root_corporation aname on acorp.value = aname.EXTERNAL_ID
left join v_root_corporation cname on ccorp.value = cname.EXTERNAL_ID
where  r.grouping_line_id is null and
       r.line_type_id = 1 /*RECKONING_TYPE_ORDINARY_INT*/ and
       r.state_id in ( 5 /*RECKONING_STATE_ACCRUED*/,
                       9 /*RECKONING_STATE_PAYMENT_FAILED*/,
                      10 /*RECKONING_STATE_PAYM_DISCARDED*/) and
       i.id = 1 -- пасиви
order by a.nls, r.date_from;

PROMPT *** Create  grants  V_INTEREST_TO_PAYMENT ***
grant SELECT                                                                 on V_INTEREST_TO_PAYMENT to UPLD;
grant SELECT                                                                 on V_INTEREST_TO_PAYMENT to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INTEREST_TO_PAYMENT.sql =========*** 
PROMPT ===================================================================================== 
