

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_DPU.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_DPU ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_DPU ("RNK", "NMS", "ID") AS 
  select a.rnk,a.nms, d.Deposit_id id from DPT_DEPOSIT d, accounts a where d.acc=a.acc and a.dazs is null
                        union all select a.rnk,a.nms, d.Dpu_id     id from DPU_DEAL    d, accounts a where d.acc=a.acc and a.dazs is null;

PROMPT *** Create  grants  DPT_DPU ***
grant SELECT                                                                 on DPT_DPU         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_DPU         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_DPU.sql =========*** End *** ======
PROMPT ===================================================================================== 
