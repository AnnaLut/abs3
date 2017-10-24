

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_DEALW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_DEALW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_DEALW ("KF", "DPU_ID", "VALUE", "TAG", "NAME", "DIRECTORY_NAME", "KEY_FIELD") AS 
  select w.KF
     , w.DPU_ID
     , w.VALUE
     , f.TAG
     , f.NAME
     , mt.TABNAME
     , nvl(f.REF_COL_NM,mc.COLNAME)
  from BARS.DPU_DEALW w
 cross
  join BARS.DPU_DEAL_FIELD f
  left
  join BARS.META_TABLES mt
    on ( mt.TABID = f.REF_TAB_ID)
  left
  join BARS.META_COLUMNS mc
    on ( mc.TABID = f.REF_TAB_ID and mc.SHOWRETVAL = 1 )
;

PROMPT *** Create  grants  V_DPU_DEALW ***
grant SELECT                                                                 on V_DPU_DEALW     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_DEALW.sql =========*** End *** ==
PROMPT ===================================================================================== 
