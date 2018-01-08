

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADDRESS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_ADDRESS ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_ADDRESS ("SETTLEMENT_ID", "SETTLEMENT_NAME", "AREA_ID", "AREA_NAME", "REGION_NAME", "REGION_ID", "SETTLEMENT_TYPE", "SETTLEMENT_TP_NM") AS 
  SELECT t.settlement_id
      ,t.settlement_name
      ,t1.area_id
      ,t1.area_name
      ,t2.region_name
      ,t2.region_id
      ,CASE t3.settlement_tp_nm
         WHEN '����' THEN
          '�.'
         WHEN '���' THEN
          '���.'
         WHEN '����' THEN
          'c.'
         WHEN '������' THEN
          'c��.'
         WHEN '����' THEN
          '�.'
       END settlement_type
      ,t3.settlement_tp_nm
  FROM adr_settlements      t
      ,adr_areas            t1
      ,adr_regions          t2
      ,adr_settlement_types t3
 WHERE 1 = 1
   AND t1.area_id(+) = t.area_id
   AND t2.region_id(+) = t.region_id
   AND t3.settlement_tp_id = t.settlement_type_id;

PROMPT *** Create  grants  VW_ESCR_ADDRESS ***
grant SELECT                                                                 on VW_ESCR_ADDRESS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADDRESS.sql =========*** End **
PROMPT ===================================================================================== 
