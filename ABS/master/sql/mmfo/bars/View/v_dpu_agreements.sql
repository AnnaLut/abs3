

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_AGREEMENTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_AGREEMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_AGREEMENTS ("AGRMNT_ID", "AGRMNT_NUMBER", "AGRMNT_BDATE", "AGRMNT_CRDATE", "AGRMNT_CREATOR_ID", "AGRMNT_CREATOR_NAME", "AGRMNT_PRCDATE", "AGRMNT_HANDLER_ID", "AGRMNT_HANDLER_NAME", "AGRMNT_STATE", "AGRMNT_DUE_DATE", "AGRMNT_UNDO_ID", "AGRMNT_DPU_ID", "AGRMNT_AMOUNT", "AGRMNT_RATE", "AGRMNT_FREQ", "AGRMNT_BEGIN_DATE", "AGRMNT_END_DATE", "AGRMNT_STOP_ID", "AGRMNT_TYPE_ID", "AGRMNT_TYPE_NAME", "CNTRCT_NUMBER", "CNTRCT_BEGIN_DATE", "CNTRCT_END_DATE", "CNTRCT_CUST_ID", "CNTRCT_BRANCH") AS 
  ( select ag.AGRMNT_ID,
         ag.AGRMNT_NUM,
         ag.AGRMNT_BDATE,
         ag.AGRMNT_CRDATE,
         ag.AGRMNT_CRUSER,
         cu.FIO,
         ag.AGRMNT_PRCDATE,
         ag.AGRMNT_PRCUSER,
         pu.FIO,
         ag.AGRMNT_STATE,
         ag.DUE_DATE,
         ag.UNDO_ID,
         ag.DPU_ID,
         ag.AMOUNT,
         ag.RATE,
         ag.FREQ,
         ag.BEGIN_DATE,
         ag.END_DATE,
         ag.STOP_ID,
         ag.AGRMNT_TYPE,
         tp.NAME,
         dl.ND,
         dl.DAT_BEGIN,
         dl.DAT_END,
         dl.RNK,
         dl.BRANCH
    from BARS.DPU_AGREEMENTS ag
   inner
    join BARS.DPU_AGREEMENT_TYPES tp
      on ( tp.ID = ag.AGRMNT_TYPE )
   inner
    join BARS.DPU_DEAL dl
      on ( dl.dpu_id = ag.dpu_id )
   inner
    join BARS.STAFF$BASE cu
      on ( cu.ID = ag.AGRMNT_CRUSER )
    left
    join BARS.STAFF$BASE pu
      on ( pu.ID = ag.AGRMNT_PRCUSER )
   where ag.KF = sys_context('bars_context','user_mfo')
);

PROMPT *** Create  grants  V_DPU_AGREEMENTS ***
grant SELECT                                                                 on V_DPU_AGREEMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_AGREEMENTS to DPT_ADMIN;
grant SELECT                                                                 on V_DPU_AGREEMENTS to DPT_ROLE;
grant SELECT                                                                 on V_DPU_AGREEMENTS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_AGREEMENTS.sql =========*** End *
PROMPT ===================================================================================== 
