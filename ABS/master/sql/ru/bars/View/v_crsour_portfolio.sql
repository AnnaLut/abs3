create or replace view v_crsour_portfolio as
select d.nd,
       d.kf deal_mfo,
       d.cc_id deal_number,
       a.kv currency_code,
       d.rnk party_id,
       b.mfo party_mfo,
       c.nmk party_name,
       d.sdate start_date,
       d.wdate expiry_date,
       dd.s deal_amount,
       a.ostc / 100 account_rest,
       a.ostb / 100 account_plan_rest,
       (select min(ir.ir) keep (dense_rank last order by ir.bdat)
        from   int_ratn ir
        where  ir.acc = ia.acc and
               ir.id = a.pap - 1 and
               ir.bdat <= bankdate()) interest_rate,
       nvl(a.nls, ' ') main_account,
       nvl(aa.nls, ' ') interest_account,
       nvl(dd.acckred, ' ') party_main_account,
       nvl(dd.accperc, ' ') party_interest_account,
       d.sos state_id,
       '�������' state_name,
       a.acc
from cc_deal d
join cc_add dd on dd.nd = d.nd and dd.adds = 0
join cc_vidd v on v.vidd = d.vidd
left join customer c on c.rnk = d.rnk
left join custbank b on b.rnk = d.rnk
left join accounts a on a.acc = dd.accs
left join int_accn ia on ia.acc = a.acc and
                         ia.id = a.pap - 1
left join accounts aa on aa.acc = ia.acra
where d.vidd in (3902, 3903) and
      d.sos <> 15 and
      a.dazs is null;

comment on table V_CRSOUR_PORTFOLIO is '�������� ���� ��������� �������';
comment on column V_CRSOUR_PORTFOLIO.ND is '�������������';
comment on column V_CRSOUR_PORTFOLIO.DEAL_MFO is '��� �������� �����';
comment on column V_CRSOUR_PORTFOLIO.DEAL_NUMBER is '����� �����';
comment on column V_CRSOUR_PORTFOLIO.CURRENCY_CODE is '������';
comment on column V_CRSOUR_PORTFOLIO.PARTY_ID is '������������ ��������';
comment on column V_CRSOUR_PORTFOLIO.PARTY_MFO is '��� ��������';
comment on column V_CRSOUR_PORTFOLIO.PARTY_NAME is '����� ��������';
comment on column V_CRSOUR_PORTFOLIO.START_DATE is '���� �������';
comment on column V_CRSOUR_PORTFOLIO.EXPIRY_DATE is '���� ����������';
comment on column V_CRSOUR_PORTFOLIO.DEAL_AMOUNT is '���� �����';
comment on column V_CRSOUR_PORTFOLIO.ACCOUNT_REST is '������� �������';
comment on column V_CRSOUR_PORTFOLIO.INTEREST_RATE is '³�������� ������';
comment on column V_CRSOUR_PORTFOLIO.MAIN_ACCOUNT is '�������� �������';
comment on column V_CRSOUR_PORTFOLIO.INTEREST_ACCOUNT is '������� �������';
comment on column V_CRSOUR_PORTFOLIO.PARTY_MAIN_ACCOUNT is '�������� ������� ��������';
comment on column V_CRSOUR_PORTFOLIO.PARTY_INTEREST_ACCOUNT is '������� ������� ��������';
comment on column V_CRSOUR_PORTFOLIO.STATE_ID is '������������� �������';
comment on column V_CRSOUR_PORTFOLIO.STATE_NAME is '����� �������';

grant select on v_crsour_portfolio to bars_access_defrole;
