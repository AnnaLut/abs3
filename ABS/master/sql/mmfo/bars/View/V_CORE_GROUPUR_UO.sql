PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_GROUPUR_UO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_GROUPUR_UO ***

create or replace view V_CORE_GROUPUR_UO as
select "REQUEST_ID","RNK","WHOIS","ISREZGR","CODEDRPOUGR","NAMEURGR","COUNTRYCODGR","KF" from nbu_gateway.V_CORE_GROUPUR_UO;


PROMPT *** Create  grants  V_CORE_GROUPUR_UO ***
grant SELECT                                                                 on V_CORE_GROUPUR_UO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_GROUPUR_UO.sql =========**
PROMPT ===================================================================================== 
