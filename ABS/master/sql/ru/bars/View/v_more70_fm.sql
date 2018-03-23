

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MORE70_FM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MORE70_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MORE70_FM ("RNK") AS 
  select rnk
from (
select rnk,  sum(s_k) as sum_kas,
sum(FDOSq(acc, add_months (trunc (sysdate, 'Q'), -3), trunc (sysdate, 'Q') - 1)+FKOSq(acc, add_months (trunc (sysdate, 'Q'), -3), trunc (sysdate, 'Q') - 1)) as sum_ob
from (
select a.rnk, a.acc, sum(o.sq) as s_k
  from opldok o, v_gl a
  where ref in (
         select ref from opldok
                   where fdat in ( select fdat from saldoa where acc = a.acc and fdat between add_months (trunc (sysdate, 'Q'), -3)  and trunc (sysdate, 'Q') - 1)
                         and acc = a.acc )
    and ref in (select ref from opldok
                   where fdat in ( select fdat from saldoa where acc = a.acc and fdat between add_months (trunc (sysdate, 'Q'), -3)  and trunc (sysdate, 'Q') - 1)
                         and acc in (select acc from accounts where nls like '1%'))
    and fdat between add_months (trunc (sysdate, 'Q'), -3)  and trunc (sysdate, 'Q') - 1
    and o.acc = a.acc and (nvl(a.dazs,to_date('01-01-4000','dd-mm-yyyy')) > gl.bd-1)
    and (a.nbs in ('2560', '2570', '2600', '2601', '2602', '2604',
				  '2605', '2606', '2610', '2611', '2615', '2620',
				  '2622', '2625', '2630', '2635', '2640', '2641',
				  '2642', '2643', '2650', '2651', '2652', '2655')
			   or ( a.nbs='2603' and a.kv='980'))
    and o.sos = 5
    group by a.rnk,a.acc)
    group by rnk )
    where case when nvl(sum_ob,0) <> 0 then sum_kas * 100 / sum_ob else 0 end > 70;

PROMPT *** Create  grants  V_MORE70_FM ***
grant SELECT                                                                 on V_MORE70_FM     to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MORE70_FM.sql =========*** End *** ==
PROMPT ===================================================================================== 
