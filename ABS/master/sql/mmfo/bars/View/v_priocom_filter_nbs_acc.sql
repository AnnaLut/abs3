

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_FILTER_NBS_ACC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRIOCOM_FILTER_NBS_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRIOCOM_FILTER_NBS_ACC ("BSNUM", "CURRENCY", "ACC", "STATUS", "KOD_FIL", "OPENDATE", "BALANCE", "NAME") AS 
  select
    a.nbs   as bsnum,
    a.kv    as currency,
    a.nls   as acc,
    0       as status,
    null    as kod_fil,
    a.daos  as opendate,
    abs(a.ostc)  as balance,
    a.nms   as name
from accounts a
where dazs is null or dazs is not null and dazs>bankdate_g;

PROMPT *** Create  grants  V_PRIOCOM_FILTER_NBS_ACC ***
grant SELECT                                                                 on V_PRIOCOM_FILTER_NBS_ACC to BARSREADER_ROLE;
grant SELECT                                                                 on V_PRIOCOM_FILTER_NBS_ACC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRIOCOM_FILTER_NBS_ACC to START1;
grant SELECT                                                                 on V_PRIOCOM_FILTER_NBS_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_FILTER_NBS_ACC.sql =========*
PROMPT ===================================================================================== 
