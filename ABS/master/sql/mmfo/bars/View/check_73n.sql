

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_73N.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_73N ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_73N ("REF", "NLS", "KV", "DK", "NLSK", "KVK", "S", "S2", "NAZN", "VDATE", "ISP", "USER_NAME", "D73") AS 
  select
      o.ref,p.nls,o.kv,a.dk,o.nlsb,o.kv2,o.s,o.s2,o.nazn,o.vdat,s.id,
      s.fio,NVL(aux1.value,'000')
from
      oper o, staff s, operw aux1, opldok a, accounts p
where
      a.acc=p.acc and p.nls like '100%' and p.kv<>980 and
      a.sos=5 and a.ref=o.ref and s.id=o.userid and
      aux1.tag (+)='D#73' and aux1.ref (+) =o.ref and
      a.dk=0
union all
select
      o.ref,p.nls,o.kv,a.dk,o.nlsa,o.kv2,o.s,o.s2,o.nazn,o.vdat,s.id,
      s.fio,NVL(aux1.value,'000')
from
      oper o, staff s, operw aux1, opldok a, accounts p
where
      a.acc=p.acc and p.nls like '100%' and p.kv<>980 and
      a.sos=5 and a.ref=o.ref and s.id=o.userid and
      aux1.tag (+)='D#73' and aux1.ref (+) =o.ref and
      a.dk=1;

PROMPT *** Create  grants  CHECK_73N ***
grant SELECT                                                                 on CHECK_73N       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_73N       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_73N.sql =========*** End *** ====
PROMPT ===================================================================================== 
