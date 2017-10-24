CREATE OR REPLACE FORCE VIEW BARS.CC_DOPW_MOS
(
   ND,
   TAG,
   NAME,
   VAL,
   SEM 
)
AS
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
                  

GRANT SELECT ON BARS.CC_DOPW_MOS TO BARS_ACCESS_DEFROLE;

begin 
execute immediate 'alter table ND_TXT_UPDATE modify TAG VARCHAR2(8 BYTE)';
end;
/
commit;