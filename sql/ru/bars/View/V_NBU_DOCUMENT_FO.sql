PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_DOCUMENT_FO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_DOCUMENT_FO ***

create or replace view V_NBU_DOCUMENT_FO as
select "RNK","TYPED","SERIYA","NOMERD","DTD","STATUS","STATUS_MESSAGE","KF" from NBU_DOCUMENT_FO;

PROMPT *** Create  grants  V_NBU_DOCUMENT_FO ***
grant SELECT                                                                 on V_NBU_DOCUMENT_FO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_DOCUMENT_FO.sql =========**
PROMPT ===================================================================================== 
