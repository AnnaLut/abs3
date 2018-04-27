prompt view/vw_ref_fm_o_rep.sql
create or replace force view bars_intgr.vw_ref_fm_o_rep as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
					cast(ID as number(38)) as ID, 
											t.NAME 
											from bars.FM_O_REP t;

comment on table BARS_INTGR.VW_REF_FM_O_REP is 'Оцінка репутації клієнта ФМ';
