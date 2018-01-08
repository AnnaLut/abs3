

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_CATEGORY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_CATEGORY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_CATEGORY ("RNK", "CATEGORY_ID", "CATEGORY_NAME", "VALUE") AS 
  select c.rnk, c.category_id, r.name, c.value
  from fm_category r,
       ( select rnk, category_id, 1 value
           from customer_category
          where dat_end is null
          union all  
         select c.rnk, f.id, 0
           from customer c, fm_category f
          where (c.rnk, f.id) not in
                (select rnk, category_id
                   from customer_category
                  where dat_end is null) ) c
 where r.id = c.category_id
   and r.inuse = 1;

PROMPT *** Create  grants  V_CUSTOMER_CATEGORY ***
grant SELECT                                                                 on V_CUSTOMER_CATEGORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_CATEGORY to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_CATEGORY.sql =========*** En
PROMPT ===================================================================================== 
