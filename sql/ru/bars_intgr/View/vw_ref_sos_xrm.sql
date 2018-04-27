prompt create view bars_intgr.vw_ref_sos_xrm

create or replace force view vw_ref_sos_xrm as
select  cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
		sos,
		name 
from bars.v_sos_xrm;

comment on table vw_ref_sos_xrm is 'Статуси документів (OPER_STATUS_XRM)';