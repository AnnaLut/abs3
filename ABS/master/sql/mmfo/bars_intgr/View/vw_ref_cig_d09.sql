prompt view/vw_ref_cig_d09.sql
create or replace force view bars_intgr.vw_ref_cig_d09 as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
					cast(ID as number(38)) as ID, 
											c.KOD, 
											c.TXT from bars.CIG_D09 c;

comment on table BARS_INTGR.VW_REF_CIG_D09 is 'D09 - Позиція клієнта';

