PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_PARTNERS_UO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_PARTNERS_UO ***

create or replace view V_CORE_PARTNERS_UO as
select "REQUEST_ID","RNK","ISREZPR","CODEDRPOUPR","NAMEURPR","COUNTRYCODPR","KF" from nbu_gateway.V_CORE_PARTNERS_UO;

PROMPT *** Create  grants  V_CORE_PARTNERS_UO ***
grant SELECT                                                                 on V_CORE_PARTNERS_UO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_PARTNERS_UO.sql =========**
PROMPT ===================================================================================== 
