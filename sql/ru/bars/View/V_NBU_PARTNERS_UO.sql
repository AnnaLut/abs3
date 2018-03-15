PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_PARTNERS_UO.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_PARTNERS_UO ***

 CREATE OR REPLACE FORCE VIEW BARS.V_NBU_PARTNERS_UO AS 
 select "RNK","ISREZPR","CODEDRPOUPR","NAMEURPR","COUNTRYCODPR","STATUS","STATUS_MESSAGE" from NBU_PARTNERS_UO;

grant SELECT                                  on V_NBU_PARTNERS_UO   to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_PARTNERS_UO.sql =========*** End 
PROMPT ===================================================================================== 
