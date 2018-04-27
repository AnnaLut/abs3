prompt view/VW_REF_DEAL_TYPE
create or replace force view bars_intgr.VW_REF_DEAL_TYPE
as
select t.type, 
		t.name 
		from bars.v_deal_type_xrm t;