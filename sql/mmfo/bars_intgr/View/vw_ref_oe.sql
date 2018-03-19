prompt view/vw_ref_oe.sql
create or replace force view bars_intgr.vw_ref_oe as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
OE, 
t.NAME, 
D_CLOSE 
from bars.OE t;

comment on table BARS_INTGR.VW_REF_OE is 'Справочник форм хозяйственности';
comment on column BARS_INTGR.VW_REF_OE.OE is 'Код отрасли';
comment on column BARS_INTGR.VW_REF_OE.NAME is 'Наименование';
comment on column BARS_INTGR.VW_REF_OE.D_CLOSE is 'Дата закрытия';
