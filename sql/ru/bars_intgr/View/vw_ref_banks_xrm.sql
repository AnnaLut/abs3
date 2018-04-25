prompt view/vw_ref_banks_xrm.sql
create or replace force view vw_ref_banks_xrm as
select MFO, 
	   NB 
	   from bars.v_banks_xrm;
comment on table vw_ref_banks_xrm is 'Довідник МФО';