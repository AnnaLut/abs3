

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_SETTLEMENT_TYPES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_SETTLEMENT_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_SETTLEMENT_TYPES ("SETTLEMENT_TP_ID", "SETTLEMENT_TP_NM", "SETTLEMENT_TP_NM_CODE") AS 
  SELECT t.settlement_tp_id
      ,t.settlement_tp_nm
      ,t.settlement_tp_code
        settlement_tp_nm_code
  FROM adr_settlement_types t;

PROMPT *** Create  grants  VW_ESCR_SETTLEMENT_TYPES ***
grant SELECT                                                                 on VW_ESCR_SETTLEMENT_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_SETTLEMENT_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_SETTLEMENT_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_SETTLEMENT_TYPES.sql =========*
PROMPT ===================================================================================== 
