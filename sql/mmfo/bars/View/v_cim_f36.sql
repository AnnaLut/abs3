

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F36.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F36 ***

CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F36
(
   CREATE_DATE,
   B041,
   K020,
   P01,
   P17,
   P16,
   DOC_DATE,
   P14,
   P21,
   P21_NEW,
   P22,
   P02,
   P02_OLD,
   P06,
   P06_OLD,
   P07,
   P07_OLD,
   P08,
   P08_OLD,
   P09,
   P15,
   P18,
   P19,
   P20,
   P23,
   BRANCH,
   IS_FRAGMENT,
   TYPE_ID,
   BOUND_ID
)
AS
   SELECT f.create_date,
          f.b041,
          f.k020,
          f.p01,
          f.p17,
          f.p16,
          f.doc_date,
          f.p14,
          f.p21,
          f.p21_new,
          f.p22,
          NVL (b.p02, f.p02) AS p02,
          f.p02_old,
          NVL (b.p06, f.p06) AS p06,
          f.p06_old,
          NVL (b.p07, f.p07) AS p07,
          f.p07_old,
          NVL (b.p08, f.p08) AS p08,
          f.p08_old,
          NVL (b.p09, f.p09) AS p09,
          NVL (b.p15, f.p15) AS p15,
          NVL (b.p18, f.p18) AS p18,
          NVL (b.p19, f.p19) AS p19,
          NVL (b.p20, f.p20) AS p20,
          NVL (b.p23, f.p23) AS p23,
          f.branch,
          f.is_fragment,
          f.type_id,
          f.bound_id
     FROM bars.cim_f36 f
          LEFT OUTER JOIN (  SELECT b041,
                                    k020,
                                    p17,
                                    p16,
                                    p21,
                                    p14,
                                    p01,
                                    doc_date,
                                    MAX (create_date) AS create_date,
                                    branch
                               FROM bars.cim_f36
                              WHERE p22 = 2 AND manual_include = 0
                           GROUP BY b041,
                                    k020,
                                    p17,
                                    p16,
                                    p21,
                                    p14,
                                    p01,
                                    doc_date,
                                    branch) z
             ON     z.p01 = f.p01
                AND z.b041 = f.b041
                AND z.p14 = f.p14
                AND z.p21 = f.p21
                AND z.k020 = f.k020
                AND z.p16 = f.p16
                AND z.p17 = f.p17
                AND f.doc_date = z.doc_date
                AND z.branch = f.branch
                AND z.create_date > f.create_date
          LEFT OUTER JOIN bars.cim_f36 b
             ON     b.p01 = f.p01
                AND b.b041 = f.b041
                AND b.k020 = f.k020
                AND b.p17 = f.p17
                AND b.p16 = f.p16
                AND b.p21 = f.p21
                AND b.p14 = f.p14
                AND b.doc_date = f.doc_date
                AND b.create_date = z.create_date
                AND b.branch = f.branch
                AND b.p22 = 2
                AND b.manual_include = 0
    WHERE f.p22 = 1 AND f.manual_include = 0
          AND NOT EXISTS
                     (SELECT s.create_date
                        FROM bars.cim_f36 s
                       WHERE     s.create_date >= f.create_date
                             AND s.p01 = f.p01
                             AND s.b041 = f.b041
                             AND s.p14 = f.p14
                             AND s.p21 = f.p21
                             AND s.k020 = f.k020
                             AND s.p16 = f.p16
                             AND s.p17 = f.p17
                             AND s.doc_date = f.doc_date
                             AND s.p22 = 3
                             AND s.manual_include = 0);
COMMENT ON TABLE BARS.V_CIM_F36 IS 'Порушення строків розрахунків v 1.01.03';

COMMENT ON COLUMN BARS.V_CIM_F36.CREATE_DATE IS 'Дата створення';

COMMENT ON COLUMN BARS.V_CIM_F36.B041 IS 'Код підрозділу';

COMMENT ON COLUMN BARS.V_CIM_F36.K020 IS 'Код ОКПО';

COMMENT ON COLUMN BARS.V_CIM_F36.P01 IS 'Код зовнішньоекономічної діяльності 1 - експ, 2 - імп';

COMMENT ON COLUMN BARS.V_CIM_F36.P17 IS '№ контракту';

COMMENT ON COLUMN BARS.V_CIM_F36.P16 IS 'Дата контракту';

COMMENT ON COLUMN BARS.V_CIM_F36.P14 IS 'Код валюти';

COMMENT ON COLUMN BARS.V_CIM_F36.P21 IS 'Дата першого дня порушення';

COMMENT ON COLUMN BARS.V_CIM_F36.P21_NEW IS 'Актуальна дата першого дня порушення';

COMMENT ON COLUMN BARS.V_CIM_F36.P22 IS 'Код дії';

COMMENT ON COLUMN BARS.V_CIM_F36.P02 IS 'ВЕД';

COMMENT ON COLUMN BARS.V_CIM_F36.P02_OLD IS 'ВЕД (стара)';

COMMENT ON COLUMN BARS.V_CIM_F36.P06 IS 'Назва резидента';

COMMENT ON COLUMN BARS.V_CIM_F36.P06_OLD IS 'Назва резидента (стара)';

COMMENT ON COLUMN BARS.V_CIM_F36.P07 IS 'Адреса резидента';

COMMENT ON COLUMN BARS.V_CIM_F36.P07_OLD IS 'Адреса резидента (стара)';

COMMENT ON COLUMN BARS.V_CIM_F36.P08 IS 'Назва нерезидента';

COMMENT ON COLUMN BARS.V_CIM_F36.P08_OLD IS 'Назва нерезидента (стара)';

COMMENT ON COLUMN BARS.V_CIM_F36.P09 IS 'Код країни нерезидента';

COMMENT ON COLUMN BARS.V_CIM_F36.P15 IS 'Сума валюти';

COMMENT ON COLUMN BARS.V_CIM_F36.P18 IS '1 - поставка товару, 2 - виконання пробіт';

COMMENT ON COLUMN BARS.V_CIM_F36.P19 IS 'Відмітка про безнадійну заборгованість';

COMMENT ON COLUMN BARS.V_CIM_F36.P20 IS 'Причина виникнення заборгованості';

COMMENT ON COLUMN BARS.V_CIM_F36.P23 IS 'Дата внесення змін до інформації про резидента';

COMMENT ON COLUMN BARS.V_CIM_F36.BRANCH IS 'Підрозділ';

PROMPT *** Create  grants  V_CIM_F36 ***
grant SELECT                                                                 on V_CIM_F36       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F36       to CIM_ROLE;
grant SELECT                                                                 on V_CIM_F36       to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F36.sql =========*** End *** ====
PROMPT ===================================================================================== 