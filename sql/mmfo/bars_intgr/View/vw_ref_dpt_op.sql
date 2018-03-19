prompt view/vw_ref_dpt_op.sql
create or replace force view bars_intgr.vw_ref_dpt_op as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											d.ID, 
											d.NAME 
											from bars.DPT_OP d;

comment on table BARS_INTGR.VW_REF_DPT_OP is 'Операции с депозитными договорами';
comment on column BARS_INTGR.VW_REF_DPT_OP.ID is '№ п/п';
comment on column BARS_INTGR.VW_REF_DPT_OP.NAME is 'Наименование операции';
