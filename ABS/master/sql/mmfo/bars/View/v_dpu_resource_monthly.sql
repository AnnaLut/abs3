

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_RESOURCE_MONTHLY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_RESOURCE_MONTHLY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_RESOURCE_MONTHLY ("KF", "CCY_ID", "CCY_CODE", "MAT_MO", "DEP_AMT", "DEP_QTY") AS 
  select KF
     , CCY_ID
     , CCY_CODE
     , trunc(MAT_DT,'MM')
     , sum(DEP_AMT)
     , sum(DEP_QTY)
  from BARS.V_DPU_RESOURCE_DAILY
 GROUP BY KF, trunc(MAT_DT,'MM'), CCY_ID, CCY_CODE
 ORDER BY KF, trunc(MAT_DT,'MM'), CCY_ID
;

PROMPT *** Create  grants  V_DPU_RESOURCE_MONTHLY ***
grant SELECT                                                                 on V_DPU_RESOURCE_MONTHLY to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_RESOURCE_MONTHLY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_RESOURCE_MONTHLY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_RESOURCE_MONTHLY.sql =========***
PROMPT ===================================================================================== 
