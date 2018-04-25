create or replace force view V_RESERVED_ACC
( NLS
, KV
, NMS
, BRANCH
, ISP
, RNK
, OKPO
, NMK
, AGRM_NUM
, RSRV_ID
) as
select a.NLS, a.KV, a.NMS, a.BRANCH, a.ISP, a.RNK
     , c.OKPO, c.NMK
     , a.AGRM_NUM, a.RSRV_ID
  from ACCOUNTS_RSRV a
  join CUSTOMER c
    on ( c.RNK = a.RNK )
 where c.DATE_OFF is null;

show errors;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  V_RESERVED_ACC          is 'Зарезервовані номера рахунків';

comment on column V_RESERVED_ACC.NLS      is 'Номер рахунку';
comment on column V_RESERVED_ACC.KV       is 'Валюта рахунку';
comment on column V_RESERVED_ACC.NMS      is 'Назва рахунку';
comment on column V_RESERVED_ACC.BRANCH   is 'Код ТВБВ';
comment on column V_RESERVED_ACC.ISP      is 'Ід. відповіднального виконавця';
comment on column V_RESERVED_ACC.RNK      is 'Реєстраційний Номер Клієнта (РНК)';
comment on column V_RESERVED_ACC.AGRM_NUM is 'Номер договору банківського обслуговування (SPECPARAM.NKD)';
comment on column V_RESERVED_ACC.OKPO     is 'ЗКПО';
comment on column V_RESERVED_ACC.NMK      is 'Назва клієнта';
comment on column V_RESERVED_ACC.RSRV_ID  is 'Ід. запису про резерв номера рахунку';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on V_RESERVED_ACC to BARS_ACCESS_DEFROLE;
grant SELECT on V_RESERVED_ACC to CUST001;
