prompt create view bars_intgr.vw_ref_bp_reason

create or replace force view vw_ref_bp_reason as
select  cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
		ID,
		REASON 
from bars.bp_reason;

comment on table VW_REF_BP_REASON is 'Довідник причин сторно (STORNO_RSN)';