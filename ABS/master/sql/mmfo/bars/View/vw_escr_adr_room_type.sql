

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_ROOM_TYPE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_ADR_ROOM_TYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_ADR_ROOM_TYPE ("ID", "NAME", "VALUE") AS 
  SELECT 1 id, 'квартира' NAME, 'кв.' VALUE
  FROM dual
UNION ALL
SELECT 2 id, 'кімната' NAME, 'кімн.' VALUE
  FROM dual
UNION ALL
SELECT 3 id, 'офіс' NAME, 'оф.' VALUE
  FROM dual;

PROMPT *** Create  grants  VW_ESCR_ADR_ROOM_TYPE ***
grant SELECT                                                                 on VW_ESCR_ADR_ROOM_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_ADR_ROOM_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_ADR_ROOM_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_ADR_ROOM_TYPE.sql =========*** 
PROMPT ===================================================================================== 
