

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SAL_2017.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view SAL_2017 ***

  CREATE OR REPLACE FORCE VIEW BARS.SAL_2017 ("FDAT", "ACC", "KV", "NLS", "NLSALT", "DOS", "KOS", "DOSO", "KOSO") AS 
  select fdat, acc, kv, nls,  nlsalt, SUM( (1-dk)*s) dos   , SUM( dk*s) kos,   SUM( (1-dk)*so) doso   , SUM( dk*so) koso
from ( select  o.fdat, a.acc, a.kv, a.nls,  o.dk , o.s , a.nlsalt,   o.s * NVL( (select 1 from oper x where a.nlsalt in (x.nlsa, x.nlsb) and x.ref = o.ref ),0) so
       from opldok o, (select * from accounts where nlsalt is not null and dat_alt is not null)  a
       where o.fdat = NVL( to_date ( pul.get ('DAT'), 'dd-mm-yyyy'), gl.BD)
         and o.acc= a.acc
      )
group by  fdat , acc, kv, nls,  nlsalt
having    SUM( (1-dk)*so) >0 or SUM( dk*so) > 0   ;

PROMPT *** Create  grants  SAL_2017 ***
grant SELECT                                                                 on SAL_2017        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SAL_2017.sql =========*** End *** =====
PROMPT ===================================================================================== 
