

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADDRESS_CENTURA.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_ADDRESS_CENTURA ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_ADDRESS_CENTURA ("SETTLEMENT_ID", "SETTLEMENT_NAME", "AREA_ID", "AREA_NAME", "REGION_NAME", "REGION_ID", "SETTLEMENT_TYPE", "SETTLEMENT_TP_NM") AS 
  SELECT t.settlement_id,
          t.settlement_name,
          t1.area_id,
          t1.area_name,
          t2.region_name,
          t2.region_id,
          CASE t3.settlement_tp_nm
             WHEN 'місто' THEN 'м.'
             WHEN 'смт' THEN 'смт.'
             WHEN 'село' THEN 'c.'
             WHEN 'селище' THEN 'cел.'
             WHEN 'хутір' THEN 'х.'
          END
             settlement_type,
          t3.settlement_tp_nm
     --,t4.suburb_name
     FROM adr_settlements t,
          adr_areas t1,
          adr_regions t2,
          adr_settlement_types t3
    --,adr_suburbs          t4
    WHERE     1 = 1
          AND t1.area_id(+) = t.area_id
          AND t2.region_id(+) = t.region_id
          AND t3.settlement_tp_id = t.settlement_type_id
--AND t4.suburb_id(+) = t.suburbs_f;;

PROMPT *** Create  grants  VW_ESCR_ADDRESS_CENTURA ***
grant SELECT                                                                 on VW_ESCR_ADDRESS_CENTURA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADDRESS_CENTURA.sql =========**
PROMPT ===================================================================================== 
