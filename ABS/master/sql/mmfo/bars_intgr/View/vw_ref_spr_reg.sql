prompt view/vw_ref_spr_reg.sql
create or replace force view bars_intgr.vw_ref_spr_reg as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
C_REG, 
C_DST, 
T_STI, 
NAME_STI, 
ZIP_CODE, 
ADDRESS, 
INUSE 
from bars.SPR_REG;

comment on table BARS_INTGR.VW_REF_SPR_REG is 'Справочник налоговых инспекций';
comment on column BARS_INTGR.VW_REF_SPR_REG.C_REG is 'Код обл';
comment on column BARS_INTGR.VW_REF_SPR_REG.C_DST is 'Код район';
comment on column BARS_INTGR.VW_REF_SPR_REG.T_STI is 'Тип налог.инспекции';
comment on column BARS_INTGR.VW_REF_SPR_REG.NAME_STI is 'Наименование налог.инспекции';
comment on column BARS_INTGR.VW_REF_SPR_REG.ZIP_CODE is 'Индекс инспекции';
comment on column BARS_INTGR.VW_REF_SPR_REG.ADDRESS is 'Адрес инспекции';
