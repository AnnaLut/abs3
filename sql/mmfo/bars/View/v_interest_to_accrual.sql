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

comment on column v_interest_to_accrual.ACCOUNT_ID              is '������������� �������';
comment on column v_interest_to_accrual.INTEREST_KIND_ID        is '������������� ���� �����������';
comment on column v_interest_to_accrual.ACCOUNT_NUMBER          is '����� �������';
comment on column v_interest_to_accrual.CURRENCY_ID             is '������';
comment on column v_interest_to_accrual.ACCOUNT_NAME            is '����� �������';
comment on column v_interest_to_accrual.INTEREST_KIND_NAME      is '��� �����������';
comment on column v_interest_to_accrual.INTEREST_ACCOUNT_NUMBER is '������� �������';
comment on column v_interest_to_accrual.DATE_FROM               is '���� �';
comment on column v_interest_to_accrual.DATE_THROUGH            is '���� ��';
comment on column v_interest_to_accrual.ACCOUNT_REST            is '������� �������';
comment on column v_interest_to_accrual.INTEREST_RATE           is '³�������� ������';
comment on column v_interest_to_accrual.INTEREST_AMOUNT         is '���� �������';
comment on column v_interest_to_accrual.COUNTER_ACCOUNT         is '������� ������\������';
comment on column v_interest_to_accrual.RECKONING_STATE         is '���� �������';
comment on column v_interest_to_accrual.CORPORATION_CODE        is '��� ����������';
comment on column v_interest_to_accrual.CORPORATION_NAME        is '����� ����������';

grant select on v_interest_to_accrual to bars_access_defrole;
