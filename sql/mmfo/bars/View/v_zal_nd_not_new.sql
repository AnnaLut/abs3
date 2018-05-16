

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAL_ND_NOT_NEW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAL_ND_NOT_NEW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAL_ND_NOT_NEW ("ACC", "PAWN", "NAME", "RNK", "NMK", "NMS", "NLS", "KV", "OST", "OB22") AS 
  SELECT DISTINCT pc.acc
               ,ca.pawn
               ,ca.name
               ,a.rnk
              ,c.nmk
               ,a.nms
               ,a.nls
               ,a.kv
               ,abs(a.ostc) / 100 ost
               ,a.ob22
  FROM pawn_acc pc
  LEFT JOIN cc_pawn ca
    ON pc.pawn = ca.pawn
  JOIN accounts a
    ON a.acc = pc.acc
   AND a.dazs IS NULL
  join customer c
  on c.rnk=a.rnk
 WHERE pc.acc NOT IN
       (SELECT p.acc
          FROM cc_accp p
         WHERE p.accs IN
               (SELECT column_value
                  FROM TABLE(tools.string_to_words(pul.get_mas_ini_val('ACC_LIST')
                                                  ,p_splitting_symbol => ','))));



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAL_ND_NOT_NEW.sql =========*** End *
PROMPT ===================================================================================== 
