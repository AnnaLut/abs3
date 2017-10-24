

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TURNOVER_FM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TURNOVER_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TURNOVER_FM ("RNK") AS 
  select c.rnk
       from accounts c, saldoa s
      where     c.acc = s.acc
            and s.fdat between add_months (trunc (sysdate, 'Q'), -3)
                           and (trunc (sysdate, 'Q') - 1)
        and (c.nbs in('2560', '2570', '2600', '2601', '2602', '2604',
                      '2605', '2606', '2610', '2611', '2615', '2620',
                      '2622', '2625', '2630', '2635', '2640', '2641',
                      '2642', '2643', '2650', '2651', '2652', '2655')
                   or (c.nbs='2603' and c.kv='980'))
   group by c.rnk
     having   sum (
                 case
                    when c.kv = 980 then (s.kos + s.dos)
                    else gl.p_icurval (c.kv, (s.kos + s.dos), gl.bd)
                 end)/ 100 > 15000000;

PROMPT *** Create  grants  V_TURNOVER_FM ***
grant SELECT                                                                 on V_TURNOVER_FM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TURNOVER_FM   to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TURNOVER_FM.sql =========*** End *** 
PROMPT ===================================================================================== 
