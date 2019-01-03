

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ASVO_IN_CRNV_NOT_MMFO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ASVO_IN_CRNV_NOT_MMFO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ASVO_IN_CRNV_NOT_MMFO ("ND", "BRANCH", "DEPVIDNAME", "NLS", "KV", "SOURCE", "IDCODE", "FIO", "OST") AS 
  select m.ND, m.BRANCH, m.DEPVIDNAME, m.NLS, m.KV, m.SOURCE, m.IDCODE,  m.FIO, m.OST
from mv_asvo_immobile_crnv m
where not exists(
                  select null
                  from  mv_asvo_immobile_mmfo s
                  where m.KOD_OTD       = s.KOD_OTD
                    and m.mfo           = s.mfo
                    and m.branch        = s.branch
                    and m.norm_ACC_CARD = s.ACC_CARD
                    and m.MARK          = s.MARK
                    and m.norm_NLS      = s.norm_NLS
                    and m.ID            = s.norm_ID
                 )
  and m.branch like f_user_branch_mask
  and m.mfo = f_user_mfo
  and f_user_mfo is not null
union all
select m.ND, m.BRANCH, m.DEPVIDNAME, m.NLS, m.KV, m.SOURCE, m.IDCODE,  m.FIO, m.OST
from mv_asvo_immobile_crnv m
where not exists(
                  select null
                  from  mv_asvo_immobile_mmfo s
                  where m.KOD_OTD       = s.KOD_OTD
                    and m.mfo           = s.mfo
                    and m.branch        = s.branch
                    and m.norm_ACC_CARD = s.ACC_CARD
                    and m.MARK          = s.MARK
                    and m.norm_NLS      = s.norm_NLS
                    and m.ID            = s.norm_ID
                 )
  and f_user_mfo is null
  and f_user_branch_mask = '/%'
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ASVO_IN_CRNV_NOT_MMFO.sql =========**
PROMPT ===================================================================================== 
