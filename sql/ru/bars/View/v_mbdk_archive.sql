create or replace view v_mbdk_archive as
select d.nd,
       v.tipd                              deal_type_id,
       d.vidd                              deal_product_id,
       dd.accs                             main_account_id,
       c.rnk                               partner_id,
       d.sdate                             agreement_date,
       dd.bdate                            start_date,
       d.wdate                             expiry_date,
       d.cc_id                             deal_number,
       cb.bic                              partner_bic,
       c.nmk                               partner_name,
       dd.s                                deal_amount,
       dd.kv                               currency_id,
       a.nls                               main_account_number,
       ia.nls                              interest_account_number,
       acrn.fprocn(i.acc, i.id, dd.bdate)  interest_rate,
       currency_utl.from_fractional_units(
           nvl((select sum(case when a.pap = 1 then s.dos else s.kos end)
                from   saldoa s
                where  s.acc = ia.acc and
                       s.fdat >= dd.bdate and
                       s.fdat <= d.wdate), 0), a.kv) accrued_interest_amount,
       currency_utl.from_fractional_units(
           nvl((select sum(case when a.pap = 2 then s.dos else s.kos end)
                from   saldoa s
                where  s.acc = ia.acc and
                       s.fdat >= dd.bdate and
                       s.fdat <= d.wdate), 0), a.kv)  payed_interest_amount,
       dd.acckred                          partner_account,
       user_utl.get_user_name(d.user_id)   user_name
from   cc_deal d
join   cc_add dd on dd.nd = d.nd and dd.adds = 0
join   accounts a on a.acc = dd.accs
join   customer c on c.rnk = d.rnk
join   custbank cb on cb.rnk = c.rnk
join   cc_vidd v on v.vidd = d.vidd
left join int_accn i on i.acc = a.acc and i.id = a.pap - 1
left join accounts ia on ia.acc = i.acra
where  d.sos = 15 and
       mbk.check_if_deal_belong_to_mbdk(v.vidd) = 'Y'
order by d.nd desc;

grant select on v_mbdk_archive to bars_access_defrole;

comment on column v_mbdk_archive.nd is '������������� �����';
comment on column v_mbdk_archive.deal_type_id is '��� ����� (1 - ���������, 2 - ���������)';
comment on column v_mbdk_archive.deal_product_id is '��� �����';
comment on column v_mbdk_archive.main_account_id is '������������� ��������� ������� �� ����';
comment on column v_mbdk_archive.partner_id is '������������� ��������, � ���� �������� �����';
comment on column v_mbdk_archive.agreement_date is '���� ���������';
comment on column v_mbdk_archive.start_date is '���� ������� 䳿';
comment on column v_mbdk_archive.expiry_date is '���� ���������� 䳿';
comment on column v_mbdk_archive.deal_number is '����� �����';
comment on column v_mbdk_archive.partner_bic is '��� ��������';
comment on column v_mbdk_archive.partner_name is '��''� ��������';
comment on column v_mbdk_archive.deal_amount is '���� �����';
comment on column v_mbdk_archive.currency_id is '������';
comment on column v_mbdk_archive.main_account_number is '�������� �������';
comment on column v_mbdk_archive.interest_account_number is '������� ����������� �������';
comment on column v_mbdk_archive.interest_rate is '������ �������';
comment on column v_mbdk_archive.accrued_interest_amount is '���� ����������� �������';
comment on column v_mbdk_archive.payed_interest_amount is '���� ���������� �������';
comment on column v_mbdk_archive.partner_account is '����� ������� ��������';
comment on column v_mbdk_archive.user_name is '���������� �� ����';
