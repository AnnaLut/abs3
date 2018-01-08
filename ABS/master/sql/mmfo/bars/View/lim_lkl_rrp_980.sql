

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/LIM_LKL_RRP_980.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view LIM_LKL_RRP_980 ***

  CREATE OR REPLACE FORCE VIEW BARS.LIM_LKL_RRP_980 ("MFO", "DAT", "LIM", "OSTF") AS 
  select l.mfo,to_char(l.dat,'dd-mm-yyyy hh24:ss ') dat,
          to_char(lim/100,'99999999999D99') lim,
          to_char(ostf/100-lim/100,'99999999999D99') ostf
from lkl_rrp l,
(select kv,acc from  accounts  where kv=980 and tip='N00') a
where l.mfo='300465'
  and   l.kv=980
  and   l.kv=a.kv;

PROMPT *** Create  grants  LIM_LKL_RRP_980 ***
grant SELECT                                                                 on LIM_LKL_RRP_980 to BARSREADER_ROLE;
grant SELECT                                                                 on LIM_LKL_RRP_980 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LIM_LKL_RRP_980 to START1;
grant SELECT                                                                 on LIM_LKL_RRP_980 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/LIM_LKL_RRP_980.sql =========*** End **
PROMPT ===================================================================================== 
