
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAL_ND_NEW.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAL_ND_NEW ***


CREATE OR REPLACE VIEW V_ZAL_ND_NEW AS
SELECT distinct pap
               ,nd
               ,(select max(pr_12) from cc_accp cp where t.acc = cp.acc and nd = t.nd)  pr_12
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
               ,(select w.value from accountsW w where w.acc  = t.acc and w.tag  = 'Z_POLIS') Z_POLIS
               ,(select r013 from specparam sp where sp.acc = t.acc) R013
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
                                                ,p_splitting_symbol => ',')))) t;


PROMPT *** Create  grants  V_ZAL_ND_NEW ***
grant SELECT                                                                 on V_ZAL_ND_NEW    to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAL_ND_NEW    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAL_ND_NEW    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAL_ND_NEW.sql =========*** End *** =
PROMPT ===================================================================================== 

