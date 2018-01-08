

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SFDAT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SFDAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SFDAT ("B", "E", "Z") AS 
  SELECT NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd)             B,
          NVL (TO_DATE (pul.get_mas_ini_val ('sFdat2'), 'dd.mm.yyyy'), gl.bd)             E,
          NVL (TO_DATE (pul.get_mas_ini_val ('zFdat1'), 'dd.mm.yyyy'), gl.bd)             Z
     FROM DUAL;

PROMPT *** Create  grants  V_SFDAT ***
grant SELECT                                                                 on V_SFDAT         to BARSREADER_ROLE;
grant SELECT                                                                 on V_SFDAT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SFDAT         to START1;
grant SELECT                                                                 on V_SFDAT         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SFDAT.sql =========*** End *** ======
PROMPT ===================================================================================== 
