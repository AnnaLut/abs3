PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_OWNERJUR_UO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_OWNERJUR_UO ***

create or replace view V_CORE_OWNERJUR_UO as
select "REQUEST_ID","RNK","RNKB","NAMEOJ","ISREZOJ","CODEDRPOUOJ","REGISTRYDAYOJ","NUMBERREGISTRYOJ","COUNTRYCODOJ","PERCENTOJ","KF" from nbu_gateway.V_CORE_OWNERJUR_UO;

PROMPT *** Create  grants  V_CORE_OWNERJUR_UO ***
grant SELECT                                                                 on V_CORE_OWNERJUR_UO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_OWNERJUR_UO.sql =========**
PROMPT ===================================================================================== 
