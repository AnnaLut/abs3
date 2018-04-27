prompt view/vw_ref_passp.sql
create or replace force view bars_intgr.vw_ref_passp as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
PASSP, 
t.NAME, 
PSPTYP, 
NRF, 
REZID 
from bars.PASSP t;

comment on table BARS_INTGR.VW_REF_PASSP is 'Удостоверения физических лиц';
comment on column BARS_INTGR.VW_REF_PASSP.PASSP is 'Вид';
comment on column BARS_INTGR.VW_REF_PASSP.NAME is 'Наименование';
comment on column BARS_INTGR.VW_REF_PASSP.PSPTYP is 'Тип документа';
comment on column BARS_INTGR.VW_REF_PASSP.NRF is 'Полное название документа';
comment on column BARS_INTGR.VW_REF_PASSP.REZID is 'Резидентність';
