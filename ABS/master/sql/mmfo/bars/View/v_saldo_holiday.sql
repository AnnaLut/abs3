

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SALDO_HOLIDAY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SALDO_HOLIDAY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SALDO_HOLIDAY ("FDAT", "CDAT", "ACC", "DOS", "KOS") AS 
  SELECT /*+noparallel*/
           p.pay_bankdate fdat,
            TRUNC (p.pay_caldate) cdat,
            o.acc acc,
            SUM (DECODE (o.dk, 0, o.s)) dos,
            SUM (DECODE (o.dk, 1, o.s)) kos
       FROM oper_ext p, opldok o
      WHERE     p.REF = o.REF
            AND o.sos = 5
            AND NOT EXISTS
                   (SELECT 1
                      FROM saldoa s
                     WHERE s.acc = o.acc AND s.fdat = TRUNC (p.pay_caldate))
            AND 0 = acrn.get_collect_salho
   GROUP BY p.pay_bankdate, TRUNC (p.pay_caldate), o.acc
   UNION ALL
   SELECT fdat,
          cdat,
          acc,
          dos,
          kos
     FROM saldo_holiday
    WHERE 1 = acrn.get_collect_salho
;

PROMPT *** Create  grants  V_SALDO_HOLIDAY ***
grant SELECT                                                                 on V_SALDO_HOLIDAY to BARSREADER_ROLE;
grant SELECT                                                                 on V_SALDO_HOLIDAY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SALDO_HOLIDAY to START1;
grant SELECT                                                                 on V_SALDO_HOLIDAY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SALDO_HOLIDAY.sql =========*** End **
PROMPT ===================================================================================== 
