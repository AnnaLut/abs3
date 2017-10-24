

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_LOTTERIES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_LOTTERIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_LOTTERIES ("OB22", "NAME", "NLS_2905", "NLS_2805", "CENA", "SELL", "PAY", "VZAIM") AS 
  SELECT v.ob22, v.NAME, n.nls_2905, n.nls_2805, v.cena / 100 cena,
   CASE  WHEN n.nls_2905 IS NULL THEN NULL
   ELSE make_docinput_url  ('VA3', 'Розповсюдити',
'DisR'      , '1'           ,
'reqv_VA_KC', v.ob22        ,
'reqv_VA_NC', v.NAME,
'reqv_VA_CC', TO_CHAR(v.cena/100,'FM9999999990.00','NLS_NUMERIC_CHARACTERS = ''. ''' ),
'Nls_B'     , n.nls_2905    )    END sell,
   CASE  WHEN n.nls_2805 IS NULL THEN NULL
   ELSE make_docinput_url  ('VA4', 'Сплатити'    ,
'DisR'      , '1'           ,
'reqv_VA_KC', v.ob22        ,
'reqv_VA_NC', v.NAME        ,
'Nls_B'     , n.nls_2805    )    END pay,
   CASE  WHEN n.nls_9812 IS NULL OR NVL (zalik, 0) = 0  THEN NULL
   ELSE make_docinput_url  ('VAZ', 'Взаємозалiк 1=1',
'reqv_VA_KC', v.ob22        ,
'reqv_VA_NC', v.NAME        ,
'reqv_VA_KK', '1'           ,
'Nls_A'     ,  n.nls_9812   ,
'Nls_B'     ,  NVL (n.nls_9819,branch_usr.get_branch_param2 ('NLS_9910', 0))
                            )    END vzaim
     FROM valuables_nls n, valuables v
    WHERE n.ob22 = v.ob22
      AND (n.nls_9819 IS NOT NULL OR  SUBSTR (v.ob22, 5, 1) = '#')
      AND  n.nls_2905 IS NOT NULL AND n.nls_2805 IS NOT NULL  AND v.cena > 0 ;

PROMPT *** Create  grants  V_LOTTERIES ***
grant FLASHBACK,SELECT                                                       on V_LOTTERIES     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_LOTTERIES     to PYOD001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_LOTTERIES     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_LOTTERIES     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_LOTTERIES.sql =========*** End *** ==
PROMPT ===================================================================================== 
