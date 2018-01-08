

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_FUNDED_DEBT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRIOCOM_FUNDED_DEBT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRIOCOM_FUNDED_DEBT ("OPERDATE", "OB22", "CURRENCY", "NBS", "DOCSUM") AS 
  select
    s.fdat      as operdate,
    spi.ob22    as ob22,
    a.kv        as currency,
    a.nbs       as nbs,
    abs(sum(s.ostf-s.dos+s.kos))  as docsum
from accounts a, saldoa s, specparam_int spi
where a.acc=s.acc and s.acc=spi.acc
and s.ostf-s.dos+s.kos<0
group by s.fdat, spi.ob22, a.kv, a.nbs;

PROMPT *** Create  grants  V_PRIOCOM_FUNDED_DEBT ***
grant SELECT                                                                 on V_PRIOCOM_FUNDED_DEBT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRIOCOM_FUNDED_DEBT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_FUNDED_DEBT.sql =========*** 
PROMPT ===================================================================================== 
