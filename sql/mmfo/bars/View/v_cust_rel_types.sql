

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_REL_TYPES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_REL_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_REL_TYPES ("ID", "NAME", "DATASET_ID") AS 
  select cr.id,
       cr.name,
       case
         when cr.id = -1 then
          'EMPTY'
         when cr.id = 20 then
          'TRUSTEE'
         when cr.id != 20 and cr.f_vaga = 1 then
          'VAGA'
         else
          'SIMPLE'
       end as dataset_id
  from v_cust_rel cr
 order by cr.id;

PROMPT *** Create  grants  V_CUST_REL_TYPES ***
grant SELECT                                                                 on V_CUST_REL_TYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_REL_TYPES.sql =========*** End *
PROMPT ===================================================================================== 
