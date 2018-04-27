prompt create view bars_intgr.vw_ref_op_rules_xrm

create or replace force view vw_ref_op_rules_xrm as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
TT,
TAG,
MFLAG,
ORD,
DEF from bars.v_op_rules_xrm t;

comment on table VW_REF_OP_RULES_XRM is 'Додаткові реквізити для операції(KOP_TAG)';
