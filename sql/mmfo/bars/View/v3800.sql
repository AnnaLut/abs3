

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V3800.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V3800 ***

  CREATE OR REPLACE FORCE VIEW BARS.V3800 ("PR", "KV", "ISO", "S3801", "O3801", "O3800", "NO3800", "DELTA") AS 
  select  'Бал',a.kv, t.lcv, aa.nls, aa.ostc, sum(a.ostc),
         sum (gl.p_icurval(a.kv,a.ostc,bankdate)),
         sum (gl.p_icurval(a.kv,a.ostc,bankdate))+aa.ostc
 from accounts a, accounts aa, tabval t
 where a.kv=t.kv and t.s3801=aa.nls and a.nbs=3800 and
       (aa.ostc<>0 or a.ostc<>0)
 group by a.kv,t.lcv,aa.nls, aa.ostc
union all
select  'ВнБал',a.kv, t.lcv, aa.nls, aa.ostc, sum(a.ostc),
         sum (gl.p_icurval(a.kv,a.ostc,bankdate)),
         sum (gl.p_icurval(a.kv,a.ostc,bankdate))+aa.ostc
 from accounts a,      accounts aa,      tabval t
 where a.kv=t.kv and  t.s9281=aa.nls and  a.nbs=9920  and
       (aa.ostc<>0 or a.ostc<>0) and aa.kv=980 and a.kv<>980
 group by a.kv,t.lcv,aa.nls, aa.ostc
 union all
 select '',0,'PA3OM', ' ',sum(decode(kv,980,ostc,0)), 0,
        sum(decode(kv,980,0,gl.p_icurval(kv,ostc,bankdate))),
        sum(decode(kv,980,0,gl.p_icurval(kv,ostc,bankdate)))+
        sum(decode(kv,980,ostc,0))
 from accounts where nbs in (3800,3801,9920) and nls<>9920103;

PROMPT *** Create  grants  V3800 ***
grant SELECT                                                                 on V3800           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V3800           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V3800.sql =========*** End *** ========
PROMPT ===================================================================================== 
