

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_RELATION_TYPES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_RELATION_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_RELATION_TYPES ("RNK", "REL_INTEXT", "REL_RNK", "REL_ID", "REL_NAME", "DATASET_ID", "RELID_SELECTED") AS 
  select cr.rnk,
       cr.rel_intext,
       cr.rel_rnk,
       crt.id as rel_id,
       crt.name as rel_name,
       crt.dataset_id,
       (select decode(count(*), 0, 0, 1)
          from customer_rel cr0
         where cr0.rnk = cr.rnk
           and cr0.rel_intext = cr.rel_intext
           and cr0.rel_rnk = cr.rel_rnk
           and cr0.rel_id = crt.id) as relid_selected
  from (select rnk, rel_intext, rel_rnk
          from customer_rel
         group by rnk, rel_intext, rel_rnk) cr,
       v_cust_rel_types crt
 order by cr.rnk, cr.rel_intext, cr.rel_rnk, crt.id;

PROMPT *** Create  grants  V_CUST_RELATION_TYPES ***
grant SELECT                                                                 on V_CUST_RELATION_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUST_RELATION_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_RELATION_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_RELATION_TYPES.sql =========*** 
PROMPT ===================================================================================== 
