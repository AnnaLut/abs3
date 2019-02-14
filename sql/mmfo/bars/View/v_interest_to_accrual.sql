create or replace view v_interest_to_accrual as
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
                           interest_utl.generate_accrual_purpose(r.id, i.metr, a.nls, r.date_from, r.date_through, r.interest_rate, r.is_grouping_unit)
                      else r.accrual_purpose
                 end
            else ''
       end accrual_purpose,
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
join   int_idn ik on ik.id = i.id
left join saldo ia on ia.acc = i.acra
left join accounts ca on ca.acc = i.acrb
left join accountsw acorp on acorp.acc = a.acc and acorp.tag = 'OBCORP'
left join customerw ccorp on ccorp.rnk = a.rnk and ccorp.TAG = 'OBPCP' 
left join v_root_corporation aname on acorp.value = aname.EXTERNAL_ID
left join v_root_corporation cname on ccorp.value = cname.EXTERNAL_ID
left join staff$base s on s.id = a.isp
where  r.grouping_line_id is null and
       r.line_type_id = 1 /*RECKONING_TYPE_ORDINARY_INT*/ and
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
