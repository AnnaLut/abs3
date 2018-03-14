PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_PERSON_UO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_PERSON_UO ***

create or replace view V_CORE_PERSON_UO as
select "REQUEST_ID","RNK","NAMEUR","ISREZ","CODEDRPOU","REGISTRYDAY","NUMBERREGISTRY","K110","EC_YEAR","COUNTRYCODNEREZ","ISMEMBER","ISCONTROLLER","ISPARTNER","ISAUDIT","K060","COMPANY_CODE","DEFAULT_COMPANY_KF","DEFAULT_COMPANY_ID","COMPANY_OBJECT_ID","STATUS","STATUS_MESSAGE","KF" from nbu_gateway.V_CORE_PERSON_UO;


PROMPT *** Create  grants  V_CORE_PERSON_UO ***
grant SELECT                                                                 on V_CORE_PERSON_UO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_PERSON_UO.sql =========**
PROMPT ===================================================================================== 
