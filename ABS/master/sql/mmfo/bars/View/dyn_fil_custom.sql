

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DYN_FIL_CUSTOM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view DYN_FIL_CUSTOM ***

  CREATE OR REPLACE FORCE VIEW BARS.DYN_FIL_CUSTOM ("RNK") AS 
  SELECT "RNK"
     FROM (WITH a
                   AS (SELECT acc
                         FROM accounts a, customer c
                        WHERE     a.rnk = c.rnk
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
                  (  SELECT rnk, NVL (SUM (dos + kos), 0) *3 AS amount -- сума перед попер. кварталу *3
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
            WHERE p.rnk = b.rnk AND b.amount > 0 AND p.amount > b.amount);

PROMPT *** Create  grants  DYN_FIL_CUSTOM ***
grant SELECT                                                                 on DYN_FIL_CUSTOM  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DYN_FIL_CUSTOM  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DYN_FIL_CUSTOM.sql =========*** End ***
PROMPT ===================================================================================== 
