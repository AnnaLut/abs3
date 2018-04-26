

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAP_ZVT_REP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAP_ZVT_REP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAP_ZVT_REP ("PRN", "DESCRIPTION") AS 
  SELECT prn,
             CASE prn
                 WHEN 0 THEN 'Перегляд-0'
                 WHEN 1 THEN 'Папки бух_облік-1'
                 WHEN 2 THEN 'Папка(26,27)-2'
                 WHEN 3 THEN 'Папка(38,39)-3'
                 WHEN 4 THEN 'Папки бек-офіс-4'
             END
                 DESCRIPTION
        FROM pap_zvt
       WHERE prn IS NOT NULL
    GROUP BY prn;

PROMPT *** Create  grants  V_PAP_ZVT_REP ***
grant SELECT                                                                 on V_PAP_ZVT_REP   to START1;
grant SELECT                                                                 on V_PAP_ZVT_REP   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAP_ZVT_REP.sql =========*** End *** 
PROMPT ===================================================================================== 
