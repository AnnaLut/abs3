create or replace view v_crsour_archive as
select d.nd,
       d.kf deal_mfo,
       d.cc_id deal_number,
       a.kv currency_code,
       d.rnk party_id,
       (select b.mfo from custbank b where b.rnk = d.rnk) party_mfo,
       c.nmk party_name,
       d.sdate start_date,
       d.wdate expiry_date,
       dd.s deal_amount,
       a.ostc / 100 account_rest,
       (select min(ir.ir) keep (dense_rank last order by ir.bdat)
        from   int_ratn ir
        where  ir.acc = ia.acc and
               ir.id = case when v.tipd = 1 then 0 else 1 end and
               ir.bdat <= bankdate()) interest_rate,
       a.nls main_account,
       aa.nls interest_account,
       dd.acckred party_main_account,
       dd.accperc party_interest_account,
       d.sos state_code,
       'Закрита' state_name
from cc_deal d
join cc_add dd on dd.nd = d.nd and dd.adds = 0
join cc_vidd v on v.vidd = d.vidd
left join customer c on c.rnk = d.rnk
left join accounts a on a.acc = dd.accs
left join int_accn ia on ia.acc = a.acc and
                         ia.id = case when v.tipd = 1 then 0 else 1 end
left join accounts aa on aa.acc = ia.acra
where d.vidd in (3902, 3903) and
      d.sos = 15;

comment on table v_crsour_archive is 'Портфель угод кредитних ресурсів';
comment on column v_crsour_archive.nd is 'Ідентифікатор';
comment on column v_crsour_archive.deal_mfo is 'МФО власника угоди';
comment on column v_crsour_archive.deal_number is 'Номер угоди';
comment on column v_crsour_archive.currency_code is 'Валюта';
comment on column v_crsour_archive.party_id is 'Ідентифкатор партнера';
comment on column v_crsour_archive.party_mfo is 'МФО партнера';
comment on column v_crsour_archive.party_name is 'Назва партнера';
comment on column v_crsour_archive.start_date is 'Дата початку';
comment on column v_crsour_archive.expiry_date is 'Дата завершення';
comment on column v_crsour_archive.deal_amount is 'Сума угоди';
comment on column v_crsour_archive.account_rest is 'Залишок рахунків';
comment on column v_crsour_archive.interest_rate is 'Відсоткова ставка';
comment on column v_crsour_archive.main_account is 'Основний рахунок';
comment on column v_crsour_archive.interest_account is 'Рахунок відсотків';
comment on column v_crsour_archive.party_main_account is 'Основний рахунок партнера';
comment on column v_crsour_archive.party_interest_account is 'Рахунок відсотків партнера';
comment on column v_crsour_archive.state_code is 'Код статусу';
comment on column v_crsour_archive.state_name is 'Назва статусу';

grant select on v_crsour_archive to bars_access_defrole;
