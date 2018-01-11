

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_COUNT_TT_FM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_COUNT_TT_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_COUNT_TT_FM ("RNK") AS 
  (  select ac.rnk
        from opldok op, opldok od, accounts ac
       where     op.ref = od.ref
             and op.stmt = od.stmt
             and decode (op.dk, 1, 0, 1) = od.dk
             and od.acc = ac.acc
             and op.acc in (select acc
                              from accounts
                             where    nls like '1001%'
                                   or nls like '1002%'
                                   or nls like '1005%'
                                   or nls like '2902%')
             and od.acc in (select acc
                              from accounts
                             where ( nbs in ('2560', '2570', '2600', '2601', '2602', '2604',
                      '2605', '2606', '2610', '2611', '2615', '2620',
                      '2622', '2625', '2630', '2635', '2640', '2641',
                      '2642', '2643', '2650', '2651', '2652', '2655')
                   or ( nbs='2603' and kv='980'))
							 )
             and op.fdat between add_months (trunc (sysdate, 'Q'), -3)
                             and trunc (sysdate, 'Q') - 1
             and op.sos = 5
    group by od.acc, ac.rnk
      having count (op.dk) >= 30);

PROMPT *** Create  grants  V_COUNT_TT_FM ***
grant SELECT                                                                 on V_COUNT_TT_FM   to BARSREADER_ROLE;
grant SELECT                                                                 on V_COUNT_TT_FM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_COUNT_TT_FM   to CUST001;
grant SELECT                                                                 on V_COUNT_TT_FM   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_COUNT_TT_FM.sql =========*** End *** 
PROMPT ===================================================================================== 
