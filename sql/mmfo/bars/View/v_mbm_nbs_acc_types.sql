

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_NBS_ACC_TYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_NBS_ACC_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_NBS_ACC_TYPES ("NBS", "TYPE_ID", "NAME") AS 
  select
    a.NBS,
    a.TYPE_ID,
    b.NAME
from
    MBM_NBS_ACC_TYPES a,
    MBM_ACC_TYPES b
where
    a.TYPE_ID = b.TYPE_ID;

PROMPT *** Create  grants  V_MBM_NBS_ACC_TYPES ***
grant SELECT                                                                 on V_MBM_NBS_ACC_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBM_NBS_ACC_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBM_NBS_ACC_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_NBS_ACC_TYPES.sql =========*** En
PROMPT ===================================================================================== 
