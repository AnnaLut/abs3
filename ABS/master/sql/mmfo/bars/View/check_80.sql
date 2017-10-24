

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_80.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_80 ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_80 ("REF", "NLS", "KV", "NLSK", "KVK", "S", "S2", "NAZN", "VDATE", "ISP", "USER_NAME", "VID") AS 
  select
      z.ref,z.nlsd,z.kv,z.nlsk,z.kv,TO_NUMBER(z.s*100,'9999999999999999.99'),
      TO_NUMBER(gl.p_icurval(z.kv,z.s*100,z.fdat),'9999999999999999.99'),
      z.nazn, z.fdat, s.id, s.fio, a.vid
from
      (select nls, kv, vid from accounts where (vid=15 or vid=16 or vid=17)) a,
      provodki z, oper o, staff s
where
      (a.nls=z.nlsd or a.nls=z.nlsk) and a.kv=z.kv and
      o.ref=z.ref and o.userid=s.id
ORDER BY z.fdat, z.nlsd;

PROMPT *** Create  grants  CHECK_80 ***
grant SELECT                                                                 on CHECK_80        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_80        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_80.sql =========*** End *** =====
PROMPT ===================================================================================== 
