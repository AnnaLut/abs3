

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAL_ND_NOT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAL_ND_NOT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAL_ND_NOT ("RNK", "NMK", "NMS", "NLS", "KV", "OST", "ACC", "PAWN", "NAME", "OB22", "ND", "IN_ND") AS 
  select "RNK","NMK","NMS","NLS","KV","OST","ACC","PAWN","NAME","OB22","ND","IN_ND" from (WITH all_zal_nd AS
 (SELECT DISTINCT ca.acc, cp.pawn, cp.name
    FROM cc_accp ca
    left JOIN pawn_acc pc
      ON ca.acc = pc.acc
    JOIN cc_pawn cp
      ON pc.pawn = cp.pawn
where ca.nd=TO_NUMBER (pul.Get_Mas_Ini_Val ('ND')))
SELECT a.rnk
      ,c.nmk
      ,a.nms
      ,a.nls
      ,a.kv
      ,abs(a.ostc) / 100 ost
      ,az.acc
      ,az.pawn
      ,az.name
      ,a.ob22
      ,TO_NUMBER (pul.Get_Mas_Ini_Val ('ND')) nd
      ,1 as in_nd
  FROM all_zal_nd az
  JOIN accounts a
    ON a.acc = az.acc
   AND a.dazs IS NULL
  JOIN customer c
    ON c.rnk = a.rnk)
union all
select "RNK","NMK","NMS","NLS","KV","OST","ACC","PAWN","NAME","OB22","ND","IN_ND" FROM (
    WITH all_zal AS
 (SELECT DISTINCT ca.acc, cp.pawn, cp.name
    FROM cc_accp ca
    left JOIN pawn_acc pc
      ON ca.acc = pc.acc
    JOIN cc_pawn cp
      ON pc.pawn = cp.pawn
   WHERE  NOT exists
         (SELECT na.acc FROM cc_accp na WHERE na.nd = TO_NUMBER (pul.Get_Mas_Ini_Val ('ND')) and na.acc=ca.acc))
SELECT a.rnk
      ,c.nmk
      ,a.nms
      ,a.nls
      ,a.kv
      ,abs(a.ostc) / 100 ost
      ,az.acc
      ,az.pawn
      ,az.name
      ,a.ob22
      ,TO_NUMBER (pul.Get_Mas_Ini_Val ('ND')) nd
      ,0 as in_nd
  FROM all_zal az
  JOIN accounts a
    ON a.acc = az.acc
   AND a.dazs IS NULL
  JOIN customer c
    ON c.rnk = a.rnk);

PROMPT *** Create  grants  V_ZAL_ND_NOT ***
grant SELECT                                                                 on V_ZAL_ND_NOT    to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAL_ND_NOT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAL_ND_NOT    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAL_ND_NOT.sql =========*** End *** =
PROMPT ===================================================================================== 
