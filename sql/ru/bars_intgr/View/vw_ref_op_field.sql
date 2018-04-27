prompt create view bars_intgr.vw_ref_op_field

create or replace force view vw_ref_op_field as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
TAG,
NAME,
TYPE,
HAVERB,
nvl(v.VIEW_NAME, 'VW_REF_TAG_VALUE') as SRC
from bars.v_op_field_xrm x
left join user_views v on 'VW_REF_'||x.dict = v.VIEW_NAME;

comment on table VW_REF_OP_FIELD is 'Додаткові реквізити (TAG)';