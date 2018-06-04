prompt create view bars_intgr.vw_ref_tag_value

create or replace force view vw_ref_tag_value as
select  cast(bars.F_OURMFO_G as varchar2(6)) MFO,
        tag,
        key as BUS_KEY,
        descr 
from table(bars.xrm_dyn_dict.get_tag_value) t;

comment on table vw_ref_tag_value is '������ �������� ����(TAG_VALUE)';