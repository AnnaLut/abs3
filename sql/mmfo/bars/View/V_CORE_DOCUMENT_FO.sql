PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_DOCUMENT_FO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_DOCUMENT_FO ***

create or replace view V_CORE_DOCUMENT_FO as
select "REQUEST_ID","RNK","TYPED","SERIYA","NOMERD","DTD","KF" from nbu_gateway.V_CORE_DOCUMENT_FO;

PROMPT *** Create  grants  V_CORE_DOCUMENT_FO ***
grant SELECT                                                                 on V_CORE_DOCUMENT_FO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_DOCUMENT_FO.sql =========**
PROMPT ===================================================================================== 
