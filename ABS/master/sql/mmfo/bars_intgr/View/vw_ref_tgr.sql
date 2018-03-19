prompt view/vw_ref_tgr.sql
create or replace force view bars_intgr.vw_ref_tgr as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
TGR, 
t.NAME 
from bars.TGR t;

comment on table BARS_INTGR.VW_REF_TGR is 'Тип  Госреестра';
comment on column BARS_INTGR.VW_REF_TGR.TGR is 'Код';
comment on column BARS_INTGR.VW_REF_TGR.NAME is 'Наименование';
