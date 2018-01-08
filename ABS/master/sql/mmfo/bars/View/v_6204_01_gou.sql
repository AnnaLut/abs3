

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_6204_01_GOU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_6204_01_GOU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_6204_01_GOU ("B", "E", "NLS", "S20", "S10", "S99", "S") AS 
  SELECT B,
            E,
            nls,
            SUM (DECODE (tobo, '/300465/000020/', S, NULL)) / 100 S20,
            SUM (DECODE (tobo, '/300465/000010/', S, NULL)) / 100 S10,
            SUM (DECODE (tobo, '/300465/000030/', S, NULL)) / 100 S99,
            SUM (S) / 100 S
       FROM (  SELECT a3.B,
                      a3.E,
                      a3.nls,
                      a3.tobo,
                      SUM (a6.S) s
                 FROM (SELECT d.B,
                              d.E,
                              a.tobo,
                              a.nls,
                              o.REF,
                              o.stmt
                         FROM opldok o, accounts a, V_SFDAT d
                        WHERE     a.nbs = '3801'
                              AND o.acc = a.acc
                              AND o.fdat >= d.B
                              AND o.fdat <= d.E) a3,
                      (SELECT (2 * o.dk - 1) * o.s S, o.REF, o.stmt
                         FROM opldok o, accounts a, V_SFDAT d
                        WHERE     a.nbs = '6204'
                              AND a.ob22 = '01'
                              AND o.acc = a.acc
                              AND o.fdat >= d.B
                              AND o.fdat <= d.E) a6
                WHERE a6.REF = a3.REF AND a6.stmt = a3.stmt
             GROUP BY a3.B,
                      a3.E,
                      a3.nls,
                      a3.tobo)
   GROUP BY B, E, nls;

PROMPT *** Create  grants  V_6204_01_GOU ***
grant SELECT                                                                 on V_6204_01_GOU   to BARSREADER_ROLE;
grant SELECT                                                                 on V_6204_01_GOU   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_6204_01_GOU   to START1;
grant SELECT                                                                 on V_6204_01_GOU   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_6204_01_GOU.sql =========*** End *** 
PROMPT ===================================================================================== 
