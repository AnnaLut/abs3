

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_DOPW_MOS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_DOPW_MOS ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_DOPW_MOS ("ND", "TAG", "NAME", "VAL", "SEM") AS 
  SELECT TO_NUMBER (pul.Get_Mas_Ini_Val ('ND')) ND,
         t.TAG,
         t.name,
         SUBSTR ( (SELECT VALUE
                     FROM MOS_OPERW
                    WHERE TAG = t.TAG AND nd = pul.Get_Mas_Ini_Val ('ND')),
                 1,
                 100)
            VAL,
         CASE
            WHEN t.TAG = 'CIG_D13'
            THEN
               (SELECT TXT
                  FROM CIG_D13
                 WHERE kod =
                          (SELECT VALUE
                             FROM MOS_OPERW
                            WHERE     TAG = t.TAG
                                  AND nd = pul.Get_Mas_Ini_Val ('ND')))
            WHEN t.TAG = 'CIG_D16'
            THEN
               (SELECT TXT
                  FROM CIG_D16
                 WHERE kod =
                          (SELECT VALUE
                             FROM MOS_OPERW
                            WHERE     TAG = t.TAG
                                  AND nd = pul.Get_Mas_Ini_Val ('ND')))
            WHEN t.TAG = 'CIG_D17'
            THEN
               (SELECT TXT
                  FROM CIG_D17
                 WHERE kod =
                          (SELECT VALUE
                             FROM MOS_OPERW
                            WHERE     TAG = t.TAG
                                  AND nd = pul.Get_Mas_Ini_Val ('ND')))
            ELSE
               NULL
         END
            SEM
    FROM MOS_TAG t
ORDER BY t.name;

PROMPT *** Create  grants  CC_DOPW_MOS ***
grant SELECT                                                                 on CC_DOPW_MOS     to BARSREADER_ROLE;
grant SELECT                                                                 on CC_DOPW_MOS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_DOPW_MOS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_DOPW_MOS.sql =========*** End *** ==
PROMPT ===================================================================================== 
