

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_HOMEPART_TYPE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_ADR_HOMEPART_TYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_ADR_HOMEPART_TYPE ("ID", "NAME", "VALUE") AS 
  SELECT t.id, t.name, t.value FROM adr_homepart_type t;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_HOMEPART_TYPE.sql =========
PROMPT ===================================================================================== 
