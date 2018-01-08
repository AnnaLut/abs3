

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_REGION.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_REGION ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REGION ("REGION_NAME", "REGION_ID") AS 
  SELECT /*t1.area_id
      ,t1.area_name
      ,*/t2.region_name
      ,t2.region_id
  FROM/* adr_areas            t1
      ,*/adr_regions          t2
/* WHERE 1 = 1
   AND t2.region_id(+) = t1.region_id*/;

PROMPT *** Create  grants  VW_ESCR_REGION ***
grant SELECT                                                                 on VW_ESCR_REGION  to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_REGION  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_REGION  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_REGION.sql =========*** End ***
PROMPT ===================================================================================== 
