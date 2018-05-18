CREATE OR REPLACE VIEW V_ZAL_ND_NEW AS
SELECT DISTINCT pap
               ,nd
               ,pr_12
               ,acc
               ,nls
               ,kv
               ,ostb
               ,ostc
               ,pawn
               ,mpawn
               ,nree
               ,depid
               ,cc_idz
               ,sdatz
               ,rnk
               ,sv
               ,ob22
               ,mdate
               ,dazs
               ,0 del
               ,'' nazn
               ,nmk
               ,name
  FROM (SELECT 1 pap
              ,p.nd nd
              ,p.pr_12
              ,az.acc
              ,az.nls
              ,az.kv
              ,-az.ostb / 100 ostb
              ,-az.ostc / 100 ostc
              ,sz.pawn
              ,sz.mpawn
              ,sz.nree
              ,sz.deposit_id depid
              ,sz.cc_idz
              ,sz.sdatz
              ,az.rnk
              ,sz.sv / 100 sv
              ,az.ob22
              ,az.mdate
              ,az.dazs
              ,t.nmk
              ,cp.name
          FROM accounts az, pawn_acc sz, cc_accp p,customer t,CC_PAWN cp
         WHERE 1=1
          and t.rnk=az.rnk
          and cp.pawn=sz.pawn
          and  az.acc = sz.acc
           AND az.acc = p.acc(+)
           AND p.accs IN
               (SELECT column_value
                  FROM TABLE(tools.string_to_words(pul.get_mas_ini_val('ACC_LIST')
                                                ,p_splitting_symbol => ','))));
