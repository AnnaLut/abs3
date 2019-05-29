
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_nbur_dm_agreements.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_DM_AGREEMENTS ("REPORT_DATE", "KF", "AGRM_ID", "AGRM_NUM", "AGRM_TP", "AGRM_STE", "BEG_DT", "END_DT", "PRTFL_TP", "CCY_ID") AS 
  SELECT /*+ leading(o v) full(a) no_push_pred */
         v.REPORT_DATE,
          v.KF,
          a.AGRM_ID,
          a.AGRM_NUM,
          a.AGRM_TP,
          a.AGRM_STE,
          a.BEG_DT,
          a.END_DT,
          a.PRTFL_TP,
          a.CCY_ID
     FROM NBUR_REF_OBJECTS o
          JOIN NBUR_LST_OBJECTS v ON (v.OBJECT_ID = o.ID)
          JOIN NBUR_DM_AGREEMENTS_ARCH a
             ON (    a.REPORT_DATE = v.REPORT_DATE
                 AND a.KF = v.KF
                 AND a.VERSION_ID = v.VERSION_ID)
    WHERE o.OBJECT_NAME = 'NBUR_DM_AGREEMENTS' AND V.VLD = 0
;
 show err;
 
PROMPT *** Create  grants  V_NBUR_DM_AGREEMENTS ***
grant SELECT                                                                 on V_NBUR_DM_AGREEMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_DM_AGREEMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_DM_AGREEMENTS to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_nbur_dm_agreements.sql =========*** E
 PROMPT ===================================================================================== 
 