

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_ZAYU.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_ZAYU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ZAYU ("PROD", "NAME", "TERM", "AIM", "VVOD") AS 
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

PROMPT *** Create  grants  V_CCK_ZAYU ***
grant SELECT                                                                 on V_CCK_ZAYU      to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_CCK_ZAYU      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_ZAYU      to RCC_DEAL;
grant SELECT                                                                 on V_CCK_ZAYU      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CCK_ZAYU      to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_CCK_ZAYU      to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on V_CCK_ZAYU      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_ZAYU.sql =========*** End *** ===
PROMPT ===================================================================================== 
