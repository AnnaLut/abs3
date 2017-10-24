

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_REL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_REL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_REL ("ID", "NAME", "TYPE", "F_VAGA", "SORT", "B", "U", "F", "U_NREZ", "F_NREZ", "F_SPD") AS 
  select id, relatedness, type, f_vaga, sort,
       b, u, f, u_nrez, f_nrez, f_spd
  from cust_rel
 where inuse = 1;

PROMPT *** Create  grants  V_CUST_REL ***
grant SELECT                                                                 on V_CUST_REL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_REL      to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_REL.sql =========*** End *** ===
PROMPT ===================================================================================== 
