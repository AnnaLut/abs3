prompt view/vw_ref_tips.sql
create or replace force view bars_intgr.vw_ref_tips as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
TIP, 
t.NAME, 
ORD 
from bars.tips t;

comment on table BARS_INTGR.VW_REF_TIPS is 'Справочник типов счетов';
comment on column BARS_INTGR.VW_REF_TIPS.TIP is 'Тип счета';
comment on column BARS_INTGR.VW_REF_TIPS.NAME is 'Наименование типа счета';
comment on column BARS_INTGR.VW_REF_TIPS.ORD is 'Порядок сортировки';
