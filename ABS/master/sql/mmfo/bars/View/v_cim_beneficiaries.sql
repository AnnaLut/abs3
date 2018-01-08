

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_BENEFICIARIES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_BENEFICIARIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_BENEFICIARIES ("BENEF_ID", "BENEF_NAME", "COUNTRY_ID", "COUNTRY_NAME", "BENEF_ADR", "COMMENTS", "DELETE_DATE") AS 
  select b.benef_id, b.benef_name, b.country_id, c.name country_name, b.benef_adr, b.comments, b.delete_date
from cim_beneficiaries b, country c
where b.country_id=c.country(+)
order by 1 desc;

PROMPT *** Create  grants  V_CIM_BENEFICIARIES ***
grant SELECT                                                                 on V_CIM_BENEFICIARIES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CIM_BENEFICIARIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_BENEFICIARIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_BENEFICIARIES.sql =========*** En
PROMPT ===================================================================================== 
