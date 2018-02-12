create or replace view v_interest_recalculation as
select r.id,
       r.account_id,
       r.interest_kind_id,
       list_utl.get_item_name('RECKONING_LINE_TYPE', r.line_type_id) line_type,
       a.kv currency_id,
       a.nls account_number,
       ia.nls interest_account_number,
       r.date_from,
       r.date_through,
       r.interest_rate,
       currency_utl.from_fractional_units(r.account_rest, a.kv) account_rest,
       currency_utl.from_fractional_units(r.interest_amount, a.kv) interest_amount,
       list_utl.get_item_name('INTEREST_RECKONING_STATE', r.state_id) reckoning_state,
       interest_utl.get_reckoning_comment(r.id, r.state_id, r.accrual_document_id, r.payment_document_id) reckoning_comment,
       r.state_id
from   (select min(t.date_from) first_recalculation_date
        from   int_reckonings t
        where  t.line_type_id = 3 /*interest_utl.RECKONING_TYPE_CORRECTION*/ and
               t.account_id = pul.get('ACCOUNT_ID')) c
join   int_reckonings r on r.account_id = pul.get('ACCOUNT_ID') and
                           r.date_through >= c.first_recalculation_date and
                           r.grouping_line_id is null
left join accounts a on a.acc = r.account_id
left join int_accn i on i.acc = a.acc and i.id = r.interest_kind_id
left join accounts ia on ia.acc = i.acra
order by r.line_type_id, r.date_from;
