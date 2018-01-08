

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_BUILD_TYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_BUILD_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_BUILD_TYPES ("ID", "TYPE") AS 
  select "ID","TYPE" from  ESCR_BUILD_TYPES t;

PROMPT *** Create  grants  VW_ESCR_BUILD_TYPES ***
grant SELECT                                                                 on VW_ESCR_BUILD_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_BUILD_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_BUILD_TYPES.sql =========*** En
PROMPT ===================================================================================== 
