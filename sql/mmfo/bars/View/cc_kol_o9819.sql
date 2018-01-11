

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_KOL_O9819.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_KOL_O9819 ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_KOL_O9819 ("TXT", "KOD") AS 
  SELECT 'Оприбуткування',      '1'  FROM DUAL UNION ALL
   SELECT 'Списання',            '0'  FROM DUAL UNION ALL
   SELECT 'Надання в пiдзвiт',   '2'  FROM DUAL UNION ALL
   SELECT 'Поверненя з пiдзвiту','3'  FROM DUAL UNION ALL
   SELECT 'Видача в дорогу'  ,   '4'  FROM DUAL UNION ALL
   SELECT 'Прийнято з дороги',   '5'  FROM DUAL
 ;

PROMPT *** Create  grants  CC_KOL_O9819 ***
grant SELECT                                                                 on CC_KOL_O9819    to BARSREADER_ROLE;
grant SELECT                                                                 on CC_KOL_O9819    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_KOL_O9819    to RCC_DEAL;
grant SELECT                                                                 on CC_KOL_O9819    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_KOL_O9819.sql =========*** End *** =
PROMPT ===================================================================================== 
