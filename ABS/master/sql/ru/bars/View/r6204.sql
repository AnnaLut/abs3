

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/R6204.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view R6204 ***

  CREATE OR REPLACE FORCE VIEW BARS.R6204 ("B", "E", "NAME", "BRANCH", "KV", "KOLP", "PROD", "VYRU", "P6204", "KOLK", "KUPL", "ZATR", "K6204", "S6204", "KOL", "VAL", "GRN") AS 
  select f.B, f.E, a.name, a.branch, a.kv,
       a.kolp, a.prod, a.vyru,  a.p6204,
       a.kolk, a.kupl, a.zatr,  a.k6204,
               (a.p6204+a.k6204)  s6204,
                   (a.kolp+a.kolk)  KOL,
                   (a.kupl-a.prod)  VAL,
                   (a.vyru-a.zatr)  GRN
from (select k.name, k.branch, k.kv,
             nvl(pr.k,0) kolP, nvl(pr.V,0)/100 PROD, nvl(pr.G,0)/100 VYRU, nvl(pr.R,0)/100 p6204 ,
             nvl(kp.k,0) kolK, nvl(kp.V,0)/100 KUPL, nvl(kp.G,0)/100 ZATR, nvl(kp.R,0)/100 k6204
      from (select b.name, b.branch, t.kv from branch3 b, tabval t where t.kv in (840,978,643, 826)) k,
           (select decode(p.kv,980,p.kv2,p.kv) KV,  p.branch,
                   count(*) k,  sum(decode(p.kv,980,p.s2,p.s)) V, sum(decode(p.kv,980,p.s,p.s2)) G,
                   SUM( (select sum(decode(dk,0,-1,+1)*S) from opl where nls like '6204%' and ref=p.ref )) R
            from oper p, V_SFDAT d
            where p.kv <> p.kv2 and p.pdat >= d.B and p.pdat < d.E+1 and p.sos=5
              and (p.nlsa like '10%' or p.nlsb like '10%')
              and (p.dk=0 and p.kv<>980 or p.dk=1 and p.kv=980)
            group by decode(p.kv,980,p.kv2,p.kv), p.branch
           ) pr,
           (select decode(p.kv,980,p.kv2,p.kv) KV, p.branch,
                   count(*) K,  sum(decode(p.kv,980,p.s2,p.s)) V, sum(decode(p.kv,980,p.s,p.s2)) G,
                   SUM( (select sum(decode(dk,0,-1,+1)*S) from opl where nls like '6204%' and ref=p.ref)) R
            from oper p, V_SFDAT d
            where p.kv <> p.kv2 and p.pdat >= d.B and p.pdat < d.E+1 and p.sos=5
              and (p.nlsa like '10%' or p.nlsb like '10%')
              and (p.dk=1 and p.kv<>980 or p.dk=0 and p.kv=980)
            group by decode(p.kv,980,p.kv2,p.kv), p.branch
           ) kp
      where k.branch= pr.branch(+) and k.kv = pr.kv(+) and k.branch= kp.branch(+) and k.kv = kp.kv(+)
    ) a ,
    V_SFDAT f
where a.kupl>0 or a.prod> 0;

PROMPT *** Create  grants  R6204 ***
grant SELECT                                                                 on R6204           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on R6204           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/R6204.sql =========*** End *** ========
PROMPT ===================================================================================== 
