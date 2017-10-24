

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_PROVIDER_PMTL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_PROVIDER_PMTL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_PROVIDER_PMTL ("ID", "RECEIVER_NAME") AS 
  select /*View for report 'Реєстр здійснених платежів',date created = 09.04.2015 */
          id,
          receiver_name
     from sto_sbon_product
     union all
   select  0 as id,
          'Всі' as receiver_name
     from dual;

PROMPT *** Create  grants  V_STO_PROVIDER_PMTL ***
grant SELECT                                                                 on V_STO_PROVIDER_PMTL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_PROVIDER_PMTL.sql =========*** En
PROMPT ===================================================================================== 
