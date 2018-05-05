
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/vw_escr_build_types.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_BUILD_TYPES ("ID", "TYPE") AS 
  select "ID","TYPE" from  ESCR_BUILD_TYPES t
  where nvl(t.state,1) = 1
;
 show err;
 
PROMPT *** Create  grants  VW_ESCR_BUILD_TYPES ***
grant SELECT                                                                 on VW_ESCR_BUILD_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_BUILD_TYPES to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/vw_escr_build_types.sql =========*** En
 PROMPT ===================================================================================== 
 