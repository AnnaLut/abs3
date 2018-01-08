CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ZAYU
(
   PROD,
   NAME,
   TERM,
   AIM,
   VVOD
)
AS
   SELECT c.NBS || c.ob22 prod,
          SUBSTR (s.txt, 1, 100) name,
          DECODE (SUBSTR (cck_dop.get_prod_old(c.NBS || c.ob22), 4, 1),
                  '3', 'Довгий',
                  'Короткий')
             term,
          DECODE (SUBSTR (c.nbs, 3, 1),
                  '6', 'Поточнi',
                  '7', 'Iнвестиц.',
                  'Iпотека')
             AIM,
          make_url ('/barsroot/credit/cck_zay.aspx',
                    'Заявка на кредит',
                    'PROD',
                    c.NBS || c.ob22,
                    'NAME',
                    SUBSTR (s.txt, 1, 100),
                    'CUSTTYPE',
                    '2')
             VVOD
     FROM CCK_OB22 c, sb_ob22 s
    WHERE     s.d_close IS NULL
          AND s.r020 = c.nbs
          AND s.ob22 = c.ob22
          AND c.nbs IN (decode(NEWNBS.GET_STATE,0,'2062','2063'),
                        '2063',
                        '2072',
                        '2073',
                        decode(NEWNBS.GET_STATE,0,'2082','2083'),
                        '2083');

COMMENT ON TABLE BARS.V_CCK_ZAYU IS 'Заявка на кредит для ЮО';

COMMENT ON COLUMN BARS.V_CCK_ZAYU.PROD IS 'Код Продукту';

COMMENT ON COLUMN BARS.V_CCK_ZAYU.NAME IS 'Назва Продукту';

COMMENT ON COLUMN BARS.V_CCK_ZAYU.VVOD IS 'Сформувати';



GRANT SELECT ON BARS.V_CCK_ZAYU TO BARSREADER_ROLE;

GRANT SELECT, FLASHBACK ON BARS.V_CCK_ZAYU TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_CCK_ZAYU TO RCC_DEAL;

GRANT SELECT ON BARS.V_CCK_ZAYU TO UPLD;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.V_CCK_ZAYU TO WR_ALL_RIGHTS;

GRANT SELECT ON BARS.V_CCK_ZAYU TO WR_CREDIT;

GRANT SELECT, FLASHBACK ON BARS.V_CCK_ZAYU TO WR_REFREAD;
