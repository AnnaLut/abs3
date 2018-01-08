

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DOK_DN1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view DOK_DN1 ***

  CREATE OR REPLACE FORCE VIEW BARS.DOK_DN1 ("FDAT", "ID", "KOL", "S") AS 
  SELECT vdat, id,  count(*), sum(s)
FROM (select vdat,
        af1(tt,userid,kv,kv2,substr(nlsa,1,4),substr(nlsb,1,4),mfoa,mfob) ID,
        af2(ref,vdat) S
      from oper where sos=5
       )
GROUP BY vdat, id
union all
select b.fdat, decode( substr(a.nls,1,1),'9',99, '8',98, 90),
       0, sum( b.dos-gl.p_icurval(a.kv,a.dos,a.fdat) )
from sal a,saldob b where a.acc=b.acc and a.fdat=b.fdat
group by b.fdat, decode( substr(a.nls,1,1),'9',99, '8',98, 90)
union all
select fdat,-100, 0, -Least(DOS,KOS)
from (select F FDAT, sum(D) DOS, sum(K) KOS
      from (select fdat F,sum(dos) D,sum(kos) K from sal
            where nbs=3929 and kv=980  group by fdat
            union all
            select fdat,  sum(dos),  sum(kos)   from salb
            where nbs=3929 and kv<>980 group by fdat )    group by F     )
;

PROMPT *** Create  grants  DOK_DN1 ***
grant SELECT                                                                 on DOK_DN1         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOK_DN1         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DOK_DN1.sql =========*** End *** ======
PROMPT ===================================================================================== 
