prompt view/vw_ref_fm_yesno
create or replace force view bars_intgr.vw_ref_fm_yesno as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											t.NAME, 
											t.ID 
											from bars.FM_YESNO t;
