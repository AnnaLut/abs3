create or replace view v_current_accounts_interest as
select a.acc account_id,
       i.id interest_kind_id,
       c.rnk customer_id,
       a.kv currency_id,
       a.nls account_number,
       a.nms account_name,
       c.okpo,
       ia.nls interest_account_number,
       acrn.fproc(a.acc, gl.bd) interest_rate,
       i.acr_dat last_accrual_date,
       i.apl_dat last_payment_date,
       (select max(r.date_through)
        from   int_reckonings r
        where  r.account_id = a.acc and
               r.interest_kind_id = i.id and
               r.state_id in (1 /*interest_utl.RECKONING_STATE_RECKONED*/,
                              2 /*interest_utl.RECKONING_STATE_MODIFIED*/,
                              5 /*interest_utl.RECKONING_STATE_ACCRUAL_FAILED*/) and
               r.grouping_line_id is null) last_reckoning_date,
       i.stp_dat end_of_accrual,
       nvl(currency_utl.from_fractional_units(
               (select sum(r.interest_amount)
                from   int_reckonings r
                where  r.account_id = a.acc and
                       r.interest_kind_id = i.id and
                       r.state_id in (1 /*interest_utl.RECKONING_STATE_RECKONED*/,
                                      2 /*interest_utl.RECKONING_STATE_MODIFIED*/,
                                      5 /*interest_utl.RECKONING_STATE_ACCRUAL_FAILED*/) and
                       r.grouping_line_id is null), a.kv), 0) amount_to_accrual,
       case when i.id = 1 then
                 nvl(currency_utl.from_fractional_units(
                         (select sum(r.interest_amount)
                          from   int_reckonings r
                          where  r.account_id = a.acc and
                                 r.interest_kind_id = i.id and
                                 r.state_id in (4 /*interest_utl.RECKONING_STATE_ACCRUED*/,
                                                8 /*interest_utl.RECKONING_STATE_PAYMENT_FAILED*/) and
                                 r.grouping_line_id is null), a.kv), 0)
            else 0
       end amount_to_payment,
       currency_utl.from_fractional_units(ia.ostb, ia.kv) planned_interest_rest,
       currency_utl.from_fractional_units(ia.ostc, ia.kv) current_interest_rest,
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
       a.isp user_id,
       user_utl.get_user_name(a.isp) user_name,
       nvl(w.kodk, k.kodk) corporation_code,
       co.name_cli corporation_name
from   saldo a
join   int_accn i on i.acc = a.acc
join   customer c on c.rnk = a.rnk
left join saldo ia on ia.acc = i.acra
left join rnkp_kod k on k.rnk = a.rnk
left join rnkp_kod_acc w on w.acc = a.acc
left join kod_cli co on co.kod_cli = nvl(w.kodk, k.kodk)
where  a.dazs is null and
       a.branch like sys_context('bars_context', 'user_branch_mask') and
       tools.compare_range_borders(i.acr_dat, i.stp_dat) < 0 and
       a.nbs in (select n.nbs from notportfolio_nbs n
                 where  n.portfolio_code = 'CURRENT_ACCOUNT' and
                        (n.userid = sys_context('bars_global', 'user_id') or n.userid is null));



comment on column v_current_accounts_interest.account_id                is 'Ідентифікатор рахунку';
comment on column v_current_accounts_interest.interest_kind_id          is 'Ідентифікатор виду нарахування';
comment on column v_current_accounts_interest.customer_id               is 'Ідентифікатор клієнта';
comment on column v_current_accounts_interest.currency_id               is 'Валюта';
comment on column v_current_accounts_interest.account_number            is 'Номер рахунку';
comment on column v_current_accounts_interest.account_name              is 'Назва рахунку';
comment on column v_current_accounts_interest.okpo                      is 'ЄДРПОУ';
comment on column v_current_accounts_interest.interest_account_number   is 'Рахунок відсотків';
comment on column v_current_accounts_interest.interest_rate             is 'Ставка';
comment on column v_current_accounts_interest.last_accrual_date         is 'Дата нарахування';
comment on column v_current_accounts_interest.last_payment_date         is 'Дата виплати';
comment on column v_current_accounts_interest.last_reckoning_date       is 'Дата прогнозу';
comment on column v_current_accounts_interest.end_of_accrual            is 'Завершення нарахування';
comment on column v_current_accounts_interest.amount_to_accrual         is 'Сума до нарахування';
comment on column v_current_accounts_interest.amount_to_payment         is 'Сума до виплати';
comment on column v_current_accounts_interest.planned_interest_rest     is 'Плановий залишок відсотків';
comment on column v_current_accounts_interest.current_interest_rest     is 'Фактичний залишок відсотків';
comment on column v_current_accounts_interest.receiver_mfo              is 'МФО отримувача';
comment on column v_current_accounts_interest.receiver_account          is 'Рахунок отримувача';
comment on column v_current_accounts_interest.receiver_currency_id      is 'Валюта отримувача';
comment on column v_current_accounts_interest.user_id                   is 'Код виконавця';
comment on column v_current_accounts_interest.user_name                 is 'Виконавець по рахунку';
comment on column v_current_accounts_interest.corporation_code          is 'Код корпорації';
comment on column v_current_accounts_interest.corporation_name          is 'Назва корпорації';

