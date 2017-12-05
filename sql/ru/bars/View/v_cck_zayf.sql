CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ZAYF
(
   PROD,
   NAME,
   TERM,
   AIM,
   VVOD
)
AS
   SELECT c.NBS || c.ob22 prod,
          SUBSTR (s.txt, 1, 255) name,
          DECODE (SUBSTR (cck_dop.get_prod_old(c.NBS || c.ob22), 4, 1),
                  '3', 'Довгий',
                  'Короткий')
             term,
          DECODE (SUBSTR (c.nbs, 3, 1),
                  '0', 'Поточнi',
                  'Iпотека')
             AIM,
          make_url ('/barsroot/credit/cck_zay.aspx',
                    'Заявка на кредит',
                    'PROD',
                    c.NBS || c.ob22,
                    'NAME',
                    SUBSTR (s.txt, 1, 255),
                    'CUSTTYPE',
                    '3')
             VVOD
     FROM CCK_OB22 c, sb_ob22 s
    WHERE     s.d_close IS NULL
          AND s.r020 = c.nbs
          AND s.ob22 = c.ob22
          AND c.nbs IN (decode(NEWNBS.GET_STATE,0,'2202','2203'),
                        '2203',
                        '2232',
                        '2233');

COMMENT ON TABLE BARS.V_CCK_ZAYF IS 'Заявка на кредит для ФО';

COMMENT ON COLUMN BARS.V_CCK_ZAYF.PROD IS 'Код Продукту';

COMMENT ON COLUMN BARS.V_CCK_ZAYF.NAME IS 'Назва Продукту';

COMMENT ON COLUMN BARS.V_CCK_ZAYF.VVOD IS 'Сформувати';




GRANT SELECT, FLASHBACK ON BARS.V_CCK_ZAYF TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_CCK_ZAYF TO RCC_DEAL;

GRANT SELECT ON BARS.V_CCK_ZAYF TO UPLD;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.V_CCK_ZAYF TO WR_ALL_RIGHTS;

GRANT SELECT ON BARS.V_CCK_ZAYF TO WR_CREDIT;

GRANT SELECT, FLASHBACK ON BARS.V_CCK_ZAYF TO WR_REFREAD;
