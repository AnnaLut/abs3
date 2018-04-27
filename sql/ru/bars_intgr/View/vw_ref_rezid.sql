prompt view/vw_ref_rezid.sql
create or replace force view bars_intgr.vw_ref_rezid as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
REZID, 
t.NAME 
from bars.REZID t;

comment on table BARS_INTGR.VW_REF_REZID is 'Резидентность';
comment on column BARS_INTGR.VW_REF_REZID.REZID is 'Код';
comment on column BARS_INTGR.VW_REF_REZID.NAME is 'Наименование';
