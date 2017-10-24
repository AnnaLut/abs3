create or replace view V_MBM_NBS_ACC_TYPES
as
select
    a.NBS,
    a.TYPE_ID,
    b.NAME
from
    MBM_NBS_ACC_TYPES a,
    MBM_ACC_TYPES b
where 
    a.TYPE_ID = b.TYPE_ID;
    
grant select on V_MBM_NBS_ACC_TYPES to BARS_ACCESS_DEFROLE;