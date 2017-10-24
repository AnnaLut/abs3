

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ADR_STREETS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ADR_STREETS ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ADR_STREETS ("STREET_ID", "STREET_NAME", "STR_TP_NM", "SETTLEMENT_ID") AS 
  SELECT t.street_id, t.street_name, t1.str_tp_nm, t.settlement_id
  FROM adr_streets t, adr_street_types t1
 WHERE t1.str_tp_id = t.street_type;

PROMPT *** Create  grants  VW_ADR_STREETS ***
grant SELECT                                                                 on VW_ADR_STREETS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ADR_STREETS.sql =========*** End ***
PROMPT ===================================================================================== 
