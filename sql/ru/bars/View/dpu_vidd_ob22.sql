create or replace force view DPU_VIDD_OB22
( VIDD
, NAME
, KV
, S181
, NBS_DEP
, OB22_DEP
, NBS_INT
, OB22_INT
, NBS_EXP
, OB22_EXP
, NBS_RED
, OB22_RED
) as
select distinct
       v.VIDD, v.NAME, v.KV, o.S181,
       o.nbs_dep, o.ob22_dep,
       o.nbs_int, o.ob22_int,
       o.nbs_exp, o.ob22_exp,
       o.nbs_red, o.ob22_red
  FROM DPU_VIDD v
  LEFT 
  JOIN DPU_TYPES_OB22 o
    ON ( v.TYPE_ID = o.TYPE_ID AND v.BSD = o.NBS_DEP AND decode(v.KV,980,1,2) = o.R034 and v.DPU_TYPE = o.S181 )
 WHERE v.FLAG = 1;

show errors;

grant SELECT on DPU_VIDD_OB22 to BARS_ACCESS_DEFROLE;
grant SELECT on DPU_VIDD_OB22 to DPT_ADMIN;
