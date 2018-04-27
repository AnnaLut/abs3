prompt view/vw_ref_deal_type_xrm.sql
create or replace force view vw_ref_deal_type_xrm as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											v.TYPE, 
											v.NAME from bars.v_deal_type_xrm v;
comment on table vw_ref_deal_type_xrm is 'Типи договорів';