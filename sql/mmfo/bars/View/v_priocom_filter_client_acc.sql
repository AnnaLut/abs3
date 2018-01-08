

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_FILTER_CLIENT_ACC.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRIOCOM_FILTER_CLIENT_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRIOCOM_FILTER_CLIENT_ACC ("CODE", "BSNUM", "CURRENCY", "ACC", "STATUS", "KOD_FIL", "OPENDATE", "BALANCE", "NAME") AS 
  select
    c.rnk   as code,
    a.nbs   as bsnum,
    a.kv    as currency,
    a.nls   as acc,
    0       as status,
    null    as kod_fil,
    a.daos  as opendate,
    abs(a.ostc)  as balance,
    a.nms   as name
from accounts a, cust_acc c
where a.acc=c.acc;

PROMPT *** Create  grants  V_PRIOCOM_FILTER_CLIENT_ACC ***
grant SELECT                                                                 on V_PRIOCOM_FILTER_CLIENT_ACC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRIOCOM_FILTER_CLIENT_ACC to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_FILTER_CLIENT_ACC.sql =======
PROMPT ===================================================================================== 
