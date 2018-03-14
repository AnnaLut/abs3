PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_ADDRESS_FO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_ADDRESS_FO ***

create or replace view V_CORE_ADDRESS_FO as
select "REQUEST_ID","RNK","CODREGION","AREA","ZIP","CITY","STREETADDRESS","HOUSENO","ADRKORP","FLATNO","KF" from nbu_gateway.V_CORE_ADDRESS_FO;

PROMPT *** Create  grants  V_CORE_ADDRESS_FO ***
grant SELECT                                                                 on V_CORE_ADDRESS_FO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_ADDRESS_FO.sql =========**
PROMPT ===================================================================================== 
