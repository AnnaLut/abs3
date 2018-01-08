

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_INTEREST_MODE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_INTEREST_MODE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_INTEREST_MODE ("ID", "P_MODE") AS 
  SELECT id, p_mode
  FROM (SELECT 0 AS id
              ,'0-відстоки,амортизація без ЕПС,амортизація дисконту,пеня,комісія за невикористаний ліміт,комісія' AS p_mode
          FROM dual
        UNION ALL
        SELECT 1 AS id, '1-амортизація без ЕПС' AS p_mode
          FROM dual
        UNION ALL
        SELECT 2 AS id
              ,'2-амортизація дисконту' AS p_mode
          FROM dual
        UNION ALL
        SELECT 3 AS id, '3-пеня' AS p_mode
          FROM dual
        UNION ALL
        SELECT 4 AS id
              ,'4-комісія за невикористаний ліміт' AS p_mode
          FROM dual
        UNION ALL
        SELECT 5 AS id, '5-комісія' AS p_mode
          FROM dual);

PROMPT *** Create  grants  V_CCK_INTEREST_MODE ***
grant SELECT                                                                 on V_CCK_INTEREST_MODE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_INTEREST_MODE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_INTEREST_MODE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_INTEREST_MODE.sql =========*** En
PROMPT ===================================================================================== 
