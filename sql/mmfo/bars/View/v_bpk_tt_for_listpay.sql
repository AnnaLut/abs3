

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_TT_FOR_LISTPAY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_TT_FOR_LISTPAY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_TT_FOR_LISTPAY ("TT", "NAME") AS 
  select t.tt, t.name
  from obpc_trans_out o, tts t
 where o.tt = t.tt
   and o.tran_type in ('10','1A','1X')
   and exists (select 1 from ps_tts where nbs='2625' and dk=1 and tt=t.tt)
   and t.tt <> 'W4V';

PROMPT *** Create  grants  V_BPK_TT_FOR_LISTPAY ***
grant SELECT                                                                 on V_BPK_TT_FOR_LISTPAY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_TT_FOR_LISTPAY to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_TT_FOR_LISTPAY.sql =========*** E
PROMPT ===================================================================================== 
