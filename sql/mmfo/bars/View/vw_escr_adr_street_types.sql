

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_STREET_TYPES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_ADR_STREET_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_ADR_STREET_TYPES ("STR_TP_ID", "STR_TP_NM") AS 
  select t.str_tp_id,t.str_tp_nm  from ADR_STREET_TYPES t;

PROMPT *** Create  grants  VW_ESCR_ADR_STREET_TYPES ***
grant SELECT                                                                 on VW_ESCR_ADR_STREET_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_ADR_STREET_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_ADR_STREET_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_STREET_TYPES.sql =========*
PROMPT ===================================================================================== 
