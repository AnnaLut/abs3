prompt view/vw_ref_xrm_dyn_dict_tag_values.sql
create or replace force view vw_ref_xrm_dyn_dict_tag_values as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
TAG,
t.KEY,
DESCR 
from table(bars.xrm_dyn_dict.get_tag_value) t;
comment on table VW_REF_XRM_DYN_DICT_TAG_VALUES is 'Можливі значення тегів(TAG_VALUE)';