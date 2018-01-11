

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_ZAYF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_ZAYF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ZAYF ("PROD", "NAME", "TERM", "AIM", "VVOD") AS 
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

PROMPT *** Create  grants  V_CCK_ZAYF ***
grant SELECT                                                                 on V_CCK_ZAYF      to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_CCK_ZAYF      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_ZAYF      to RCC_DEAL;
grant SELECT                                                                 on V_CCK_ZAYF      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CCK_ZAYF      to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_CCK_ZAYF      to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on V_CCK_ZAYF      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_ZAYF.sql =========*** End *** ===
PROMPT ===================================================================================== 
