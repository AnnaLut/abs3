prompt view/vw_ref_codcagent.sql
create or replace force view bars_intgr.vw_ref_codcagent as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											CODCAGENT, 
											c.NAME, 
											REZID 
											from bars.CODCAGENT c;

comment on table BARS_INTGR.VW_REF_CODCAGENT is 'Характеристика контрагента';
comment on column BARS_INTGR.VW_REF_CODCAGENT.CODCAGENT is 'Код';
comment on column BARS_INTGR.VW_REF_CODCAGENT.NAME is 'Наименование';
comment on column BARS_INTGR.VW_REF_CODCAGENT.REZID is 'Резидентность';

