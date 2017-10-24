CREATE OR REPLACE VIEW V_ZAL_ND_NOT_NEW AS
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
