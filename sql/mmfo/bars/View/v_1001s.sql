

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_1001S.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_1001S ***

  CREATE OR REPLACE FORCE VIEW BARS.V_1001S ("SDAT", "BRANCH", "S840", "S643", "S978", "S826", "S959", "S961", "S124", "S756") AS 
  SELECT SUBSTR ( (pul.get_mas_ini_val ('sFdat1')), 1, 10) sdat,
            branch,
            -SUM (DECODE (kv, 840, s, 0)) / 100,
            -SUM (DECODE (kv, 643, s, 0)) / 100,
            -SUM (DECODE (kv, 978, s, 0)) / 100,
            -SUM (DECODE (kv, 826, s, 0)) / 100,
            -SUM (DECODE (kv, 959, s, 0)) / 100,
            -SUM (DECODE (kv, 961, s, 0)) / 100,
            -SUM (DECODE (kv, 124, s, 0)) / 100,
            -SUM (DECODE (kv, 756, s, 0)) / 100
       FROM (SELECT branch,
                    kv,
                    fost (
                       acc,
                       NVL (
                          TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                   'dd.mm.yyyy'),
                          gl.bd))
                       s
               FROM v_gl
              WHERE nbs IN ('1001',
                            '1002',
                            '1101',
                            '1102'))
      WHERE s <> 0 AND KV <> 980
   GROUP BY branch;

PROMPT *** Create  grants  V_1001S ***
grant FLASHBACK,SELECT                                                       on V_1001S         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_1001S         to SALGL;
grant FLASHBACK,SELECT                                                       on V_1001S         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_1001S.sql =========*** End *** ======
PROMPT ===================================================================================== 
