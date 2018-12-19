

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
  and m.branch like sys_context('BARS_CONTEXT','USER_BRANCH_MASK')
  and m.mfo = sys_context('BARS_CONTEXT','USER_MFO')
  and sys_context('BARS_CONTEXT','USER_MFO') is not null

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
  and sys_context('BARS_CONTEXT','USER_MFO') is null
  and sys_context('BARS_CONTEXT','USER_BRANCH_MASK') = '/%'
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ASVO_IN_CRNV_NOT_MMFO.sql =========**
PROMPT ===================================================================================== 
