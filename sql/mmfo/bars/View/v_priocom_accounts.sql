

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_ACCOUNTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRIOCOM_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRIOCOM_ACCOUNTS ("ACC", "CURRENCY", "STATUS", "KOD_FIL", "OPENDATE", "BALANCE", "CODE", "R020", "NAME", "CLOSEDATE", "LASTDATE", "PROCENT", "S040", "S050", "S031", "S080", "S180", "S182", "S200", "S190", "R011", "OB22", "IDCONTRACT") AS 
  select /*+ FIRST_ROWS(1) */
    a.nls       as acc,
    a.kv        as currency,
    0           as status,
    null        as kod_fil,
    a.daos      as opendate,
    abs(a.ostc) as balance,
    c.rnk       as code,
    a.nbs       as r020,
    a.nms       as name,
    a.dazs      as closedate,
    a.dapp      as lastdate,
    acrn.fproc(a.acc, gl.bd) as procent,
    a.daos      as s040,
    a.mdate     as s050,
    sp.s031     as s031,
    sp.s080     as s080,
    sp.s180     as s180,
    sp.s182     as s182,
    sp.s200     as s200,
    sp.s190     as s190,
    sp.r011     as r011,
    spi.ob22    as ob22,
    spi.priocom_idcontract  as idcontract
from accounts a, cust_acc c, specparam sp, specparam_int spi
where a.acc=c.acc and a.acc=sp.acc(+) and a.acc=spi.acc(+);

PROMPT *** Create  grants  V_PRIOCOM_ACCOUNTS ***
grant SELECT                                                                 on V_PRIOCOM_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_PRIOCOM_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRIOCOM_ACCOUNTS to START1;
grant SELECT                                                                 on V_PRIOCOM_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_ACCOUNTS.sql =========*** End
PROMPT ===================================================================================== 
