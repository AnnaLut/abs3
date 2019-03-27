

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V3800_.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V3800_ ***

  CREATE OR REPLACE FORCE VIEW BARS.V3800_ ("PR", "KV", "ISO", "S3801", "O3801", "O3800", "NO3800", "DELTA") AS 
  select  'B',a.kv, t.lcv, aa.nls, aa.ostc, sum(a.ostc),
         sum (gl.p_icurval(a.kv,a.ostc,bankdate)),
         sum (gl.p_icurval(a.kv,a.ostc,bankdate))+aa.ostc
 from accounts a, accounts aa, tabval t
 where a.kv=t.kv and t.s3801=aa.nls and a.nbs=3800 and
       (aa.ostc<>0 or a.ostc<>0)
 group by a.kv,t.lcv,aa.nls, aa.ostc
union all 
select  'N',a.kv, t.lcv, aa.nls, aa.ostc, sum(a.ostc),
         sum (gl.p_icurval(a.kv,a.ostc,bankdate)),
         sum (gl.p_icurval(a.kv,a.ostc,bankdate))+aa.ostc
 from accounts a,      accounts aa,      tabval t
 where a.kv=t.kv and  t.s9281=aa.nls and  a.nbs=9920  and
       (aa.ostc<>0 or a.ostc<>0) and aa.kv=980 and a.kv<>980
 group by a.kv,t.lcv,aa.nls, aa.ostc
 union all
 select 'R',0,'PA3OM', ' ',sum(decode(kv,980,ostc,0)), 0,
        sum(decode(kv,980,0,gl.p_icurval(kv,ostc,bankdate))),
        sum(decode(kv,980,0,gl.p_icurval(kv,ostc,bankdate)))+
        sum(decode(kv,980,ostc,0))
 from accounts where nbs in (3800,3801,9920);

PROMPT *** Create  grants  V3800T ***
grant SELECT                                                                 on V3800T          to BARSREADER_ROLE;
grant SELECT                                                                 on V3800T          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V3800T          to SALGL;
grant SELECT                                                                 on V3800T          to UPLD;

PROMPT *** Create  grants  V3800_ ***
grant SELECT                                                                 on V3800_          to BARSREADER_ROLE;
grant SELECT                                                                 on V3800_          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V3800_          to START1;
grant SELECT                                                                 on V3800_          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V3800_.sql =========*** End *** =======
PROMPT ===================================================================================== 