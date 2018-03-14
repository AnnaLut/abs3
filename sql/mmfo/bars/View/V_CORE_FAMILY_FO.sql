PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_FAMILY_FO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_FAMILY_FO ***

create or replace view V_CORE_FAMILY_FO as
select "REQUEST_ID","RNK","STATUS_F","MEMBERS","KF" from nbu_gateway.V_CORE_FAMILY_FO;

PROMPT *** Create  grants  V_CORE_FAMILY_FO ***
grant SELECT                                                                 on V_CORE_FAMILY_FO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_FAMILY_FO.sql =========**
PROMPT ===================================================================================== 
