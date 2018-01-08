

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_6204S.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_6204S ***

  CREATE OR REPLACE FORCE VIEW BARS.V_6204S ("SDAT", "BRANCH", "SA", "SP", "S") AS 
  SELECT   SUBSTR ((pul.get_mas_ini_val ('sFdat1')), 1, 10) sdat, branch,
        -SUM (DECODE (SIGN (s), -1, s, 0)) / 100,
         SUM (DECODE (SIGN (s),  1, s, 0)) / 100, SUM (s) / 100
FROM (SELECT branch,
             fost (acc,
             nvl(TO_DATE(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'),gl.bd) ) s
      FROM v_gl WHERE nbs = '6204')
      WHERE (s <> 0 OR LENGTH (branch) = 15)
GROUP BY branch;

PROMPT *** Create  grants  V_6204S ***
grant SELECT                                                                 on V_6204S         to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_6204S         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_6204S         to SALGL;
grant SELECT                                                                 on V_6204S         to UPLD;
grant FLASHBACK,SELECT                                                       on V_6204S         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_6204S.sql =========*** End *** ======
PROMPT ===================================================================================== 
