

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F98_REZ.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F98_REZ ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F98_REZ ("DT", "KO_1", "KO_1_TXT", "R1_1", "R2_1", "K020", "NOMNAK", "DATANAK", "SANKSIA1", "SANKSIA1_TXT", "SRSANK11", "NOMNAKSK", "DATNAKSK", "SRSANK12", "STATUS", "V_SANK", "OUR_CLIENT") AS 
  SELECT MIN (f.dt),
             MIN (TO_NUMBER (f.ko_1)),
             MIN (o.knb),
             MIN (f.r1_1),
             MIN (f.r2_1),
             f.k020,
             f.nomnak,
             f.datanak,
             f.sanksia1,
             CASE
                 WHEN f.sanksia1 = 'I' OR f.sanksia1 = 'І'
                 THEN
                     'Індивiдуальне лiцензування'
                 WHEN f.sanksia1 = 'З'
                 THEN
                     'Тимчасове зупинення дiяльностi'
                 WHEN f.sanksia1 = 'ПІ' AND f.sanksia1 = 'П'
                 THEN
                     'Попередження'
             END,
             MIN (f.srsank11),
             f.nomnaksk,
             f.datnaksk,
             MIN (f.srsank12),
             DECODE (
                 f.v_sank,
                 '2', 'ВІДМІНА',
                 CASE
                     WHEN f.sanksia1 = 'П' OR f.sanksia1 = 'ПІ'
                     THEN
                         'ПOПЕРЕДЖЕННЯ'
                     WHEN f.nakaz LIKE 'ПРИЗУПИН%'
                     THEN
                         'ПРИЗУПИНЕННЯ'
                     ELSE
                         'ЗАСТОСУВАННЯ'
                 END),
             v_sank,
             NVL2 (MIN (c.rnk), 1, NULL)
        FROM cim_f98 f
             LEFT OUTER JOIN kodobl o ON o.ko = TO_NUMBER (f.ko_1)
             LEFT OUTER JOIN customer c ON c.okpo = f.k020
       WHERE f.k030 = '1' AND f.delete_date IS NULL
    GROUP BY f.k020,
             f.nomnak,
             f.datanak,
             f.nomnaksk,
             f.datnaksk,
             f.sanksia1,
             f.v_sank,
             f.srsank12,
             f.nakaz
    ORDER BY f.k020, NVL (f.datnaksk, f.datanak), f.v_sank;

PROMPT *** Create  grants  V_CIM_F98_REZ ***
grant SELECT                                                                 on V_CIM_F98_REZ   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_F98_REZ   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F98_REZ   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F98_REZ.sql =========*** End *** 
PROMPT ===================================================================================== 
