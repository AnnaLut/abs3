

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ASVO_IN_MMFO_NOT_CRNV.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ASVO_IN_MMFO_NOT_CRNV ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ASVO_IN_MMFO_NOT_CRNV ("ND", "BRANCH", "DEPVIDNAME", "NLS", "KV", "SOURCE", "IDCODE", "FIO", "OST") AS 
  select s.ND, s.BRANCH, s.DEPVIDNAME, s.NLS, s.KV, s.SOURCE, s.IDCODE,  s.FIO, s.OST
from mv_asvo_immobile_mmfo s
where not exists (
                   select null
                   from  mv_asvo_immobile_crnv m
                   where m.KOD_OTD       = s.KOD_OTD
                     and m.mfo           = s.mfo
                     and m.branch        = s.branch
                     and m.norm_ACC_CARD = s.ACC_CARD
                     and m.MARK          = s.MARK
                     and m.norm_NLS      = s.norm_NLS
                     and m.ID            = s.norm_ID
                  )
  and s.branch like sys_context('BARS_CONTEXT','USER_BRANCH_MASK')
  and s.mfo = sys_context('BARS_CONTEXT','USER_MFO')
  and sys_context('BARS_CONTEXT','USER_MFO') is not null
  and s.fl in (3, -2, 0, 5 , 1)
union all
select s.ND, s.BRANCH, s.DEPVIDNAME, s.NLS, s.KV, s.SOURCE, s.IDCODE,  s.FIO, s.OST
from mv_asvo_immobile_mmfo s
where not exists (
                   select null
                   from  mv_asvo_immobile_crnv m
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
  and s.fl in (3, -2, 0, 5 , 1)
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ASVO_IN_MMFO_NOT_CRNV.sql =========**
PROMPT ===================================================================================== 
