prompt create view bars_intgr.vw_ref_rc_bnk

create or replace force view vw_ref_rc_bnk as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
b010, 
name
from bars.rc_bnk t;

comment on table vw_ref_rc_bnk is 'Коди банків (TAG_VALUE)';