PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_OWNERPP_UO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_OWNERPP_UO ***

create or replace view V_CORE_OWNERPP_UO as
select "REQUEST_ID","RNK","RNKB","LASTNAME","FIRSTNAME","MIDDLENAME","ISREZ","INN","COUNTRYCOD","PERCENT","KF" from nbu_gateway.V_CORE_OWNERPP_UO;

PROMPT *** Create  grants  V_CORE_OWNERPP_UO ***
grant SELECT                                                                 on V_CORE_OWNERPP_UO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_OWNERPP_UO.sql =========**
PROMPT ===================================================================================== 
