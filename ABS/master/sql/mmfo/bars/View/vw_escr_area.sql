

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_AREA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_AREA ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_AREA ("AREA_ID", "AREA_NAME", "REGION_NAME", "REGION_ID", "SETTLEMENT_ID", "SETTLEMENT_NAME", "SETTLEMENT_TP_NM") AS 
  SELECT t1.area_id
      ,t1.area_name
      ,t2.region_name
      ,t2.region_id
      ,t.settlement_id
      ,t.settlement_name
      ,t3.settlement_tp_nm
  FROM adr_settlements      t
      ,adr_areas            t1
      ,adr_regions          t2
      ,adr_settlement_types t3
 WHERE 1 = 1
   AND t1.area_id(+) = t.area_id
   AND t2.region_id(+) = t.region_id
   AND t3.settlement_tp_id = t.settlement_type_id;

PROMPT *** Create  grants  VW_ESCR_AREA ***
grant SELECT                                                                 on VW_ESCR_AREA    to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_AREA    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_AREA    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_AREA.sql =========*** End *** =
PROMPT ===================================================================================== 
