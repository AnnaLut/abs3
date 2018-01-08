

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DF_TURNOVER_FM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view DF_TURNOVER_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.DF_TURNOVER_FM ("RNK") AS 
  SELECT "RNK"
     FROM (WITH a
                   AS (SELECT acc
                         FROM accounts a, customer c
                        WHERE  a.rnk = c.rnk
						      AND ( nbs in ('2560', '2570', '2600', '2601', '2602', '2604',
											'2605', '2606', '2610', '2611', '2615', '2620',
											'2622', '2625', '2630', '2635', '2640', '2641',
											'2642', '2643', '2650', '2651', '2652', '2655')
										or ( nbs='2603' and kv='980'))
                              AND C.CUSTTYPE IN (2, 3)
                              AND c.date_off IS NULL
                              AND c.date_on <=
                                     ADD_MONTHS (TRUNC (SYSDATE, 'Q'), -6))
           SELECT p.rnk
             FROM (  SELECT rnk, NVL (SUM (dos + kos), 0)  AS amount -- сума попер.кварталу
                       FROM ACCM_AGG_MONBALS p
                      WHERE caldt_id IN
                               (SELECT caldt_id
                                  FROM ACCM_CALENDAR
                                 WHERE (caldt_date =
                                           ADD_MONTHS (TRUNC (SYSDATE, 'Q'),
                                                       -1))
                                       OR (caldt_date =
                                              ADD_MONTHS (TRUNC (SYSDATE, 'Q'),
                                                          -2))
                                       OR (caldt_date =
                                              ADD_MONTHS (TRUNC (SYSDATE, 'Q'),
                                                          -3)))
                            AND acc IN (SELECT acc FROM a)
                   GROUP BY rnk) p,
                  (  SELECT rnk, NVL (SUM (dos + kos), 0) *10 AS amount -- сума перед попер. кварталу *10
                       FROM ACCM_AGG_MONBALS
                      WHERE caldt_id IN
                               (SELECT caldt_id
                                  FROM ACCM_CALENDAR
                                 WHERE (caldt_date =
                                           ADD_MONTHS (TRUNC (SYSDATE, 'Q'),
                                                       -4))
                                       OR (caldt_date =
                                              ADD_MONTHS (TRUNC (SYSDATE, 'Q'),
                                                          -5))
                                       OR (caldt_date =
                                              ADD_MONTHS (TRUNC (SYSDATE, 'Q'),
                                                          -6)))
                            AND acc IN (SELECT acc FROM a)
                   GROUP BY rnk) b
            WHERE p.rnk = b.rnk AND b.amount >100000000 AND p.amount > b.amount);

PROMPT *** Create  grants  DF_TURNOVER_FM ***
grant SELECT                                                                 on DF_TURNOVER_FM  to BARSREADER_ROLE;
grant SELECT                                                                 on DF_TURNOVER_FM  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DF_TURNOVER_FM  to CUST001;
grant SELECT                                                                 on DF_TURNOVER_FM  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DF_TURNOVER_FM.sql =========*** End ***
PROMPT ===================================================================================== 
