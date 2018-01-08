

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_STREETS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_ADR_STREETS ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_ADR_STREETS ("STREET_ID", "STREET_NAME", "STR_TP_NM", "SETTLEMENT_NAME", "SETTLEMENT_ID") AS 
  SELECT t.street_id
      ,t.street_name
      ,t1.str_tp_nm
      ,t2.settlement_name
     ,t.settlement_id
  FROM adr_streets t, adr_street_types t1, adr_settlements t2
 WHERE t1.str_tp_id = t.street_type
   AND t2.settlement_id = t.settlement_id;

PROMPT *** Create  grants  VW_ESCR_ADR_STREETS ***
grant SELECT                                                                 on VW_ESCR_ADR_STREETS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_STREETS.sql =========*** En
PROMPT ===================================================================================== 
