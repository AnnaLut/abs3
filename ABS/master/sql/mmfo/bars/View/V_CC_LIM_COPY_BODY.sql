

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_LIM_COPY_BODY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_LIM_COPY_BODY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_LIM_COPY_BODY ("ID", "ND", "FDAT", "LIM2", "ACC", "NOT_9129", "SUMG", "SUMO", "OTM", "KF", "SUMK", "NOT_SN") AS 
  SELECT ID
       ,ND
       ,FDAT
       ,LIM2
       ,ACC
       ,NOT_9129
       ,SUMG
       ,SUMO
       ,OTM
       ,KF
       ,SUMK
       ,NOT_SN
  FROM cc_lim_copy_body t;

PROMPT *** Create  grants  V_CC_LIM_COPY_BODY ***
grant SELECT                                                                 on V_CC_LIM_COPY_BODY to BARSREADER_ROLE;
grant SELECT                                                                 on V_CC_LIM_COPY_BODY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_LIM_COPY_BODY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_LIM_COPY_BODY.sql =========*** End
PROMPT ===================================================================================== 
