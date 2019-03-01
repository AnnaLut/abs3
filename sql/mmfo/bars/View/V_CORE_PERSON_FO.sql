PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_PERSON_FO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_PERSON_FO ***

create or replace view V_CORE_PERSON_FO as
select "REQUEST_ID","RNK","LASTNAME","FIRSTNAME","MIDDLENAME","ISREZ","INN","BIRTHDAY","COUNTRYCODNEREZ","K060","EDUCATION","TYPEW","CODEDRPOU","NAMEW","PERSON_CODE","DEFAULT_PERSON_KF","DEFAULT_PERSON_ID","PERSON_OBJECT_ID","STATUS","STATUS_MESSAGE","KF" 
from nbu_gateway.V_CORE_PERSON_FO;



PROMPT *** Create  grants  V_CORE_PERSON_FO ***
grant SELECT                                                                 on V_CORE_PERSON_FO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_PERSON_FO.sql =========**
PROMPT ===================================================================================== 
