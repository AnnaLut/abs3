

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KOB.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KOB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KOB ("REF", "REF4", "VDAT", "ND", "NLSA", "MFOB", "NLSB", "S", "NAZN", "SOS") AS 
  SELECT o.REF, to_number(null) REF4, o.VDAT, o.ND, o.NLSA, o.MFOB,
       o.NLSB, o.S, o.NAZN,o.SOS
from oper o where o.ref in (select ref2  from kob where ref2 is not null)
union all
SELECT to_number(null) REF2, o.REF, o.VDAT, o.ND, o.NLSA, o.MFOB,
       o.NLSB, o.S, o.NAZN,o.SOS
from oper o where o.ref in (select ref4  from kob where ref4 is not null)
;

PROMPT *** Create  grants  V_KOB ***
grant SELECT                                                                 on V_KOB           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KOB           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KOB.sql =========*** End *** ========
PROMPT ===================================================================================== 
