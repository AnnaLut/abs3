

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_INT_DIVIDENTS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_INT_DIVIDENTS ***

CREATE OR REPLACE VIEW V_CP_INT_DIVIDENTS AS
SELECT c.ref, o.nd, o.datd, k.id, k.cp_id, 
      (select a.nls from cp_accounts ac, accounts a where ac.cp_ref = c.ref and ac.cp_acctype = 'RD' and ac.cp_acc = a.acc) as nlsrd,
       c.sum, c.nazn,
      c.nlsrd_6
     FROM CP_INT_DIVIDENTS c, cp_deal d, cp_kod k, oper o
    WHERE c.user_id = user_id() and c.ref = d.ref and d.id = k.id 
          and c.ref = o.ref(+);

PROMPT *** Create  grants  V_CP_INT_DIVIDENTS ***
grant SELECT                                                                 on V_CP_INT_DIVIDENTS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_INT_DIVIDENTS.sql =========*** End *** ==
PROMPT ===================================================================================== 
