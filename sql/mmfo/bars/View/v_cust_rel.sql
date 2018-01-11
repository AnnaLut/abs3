

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_REL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_REL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_REL ("ID", "NAME", "TYPE", "F_VAGA", "SORT", "B", "U", "F", "U_NREZ", "F_NREZ", "F_SPD") AS 
  SELECT id,
          relatedness,
          TYPE,
          f_vaga,
          sort,
          b,
          u,
          f,
          u_nrez,
          f_nrez,
          f_spd
     FROM cust_rel
--    WHERE inuse = 1 -- убрано для COBUMMFO-4135
;

PROMPT *** Create  grants  V_CUST_REL ***
grant SELECT                                                                 on V_CUST_REL      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUST_REL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_REL      to CUST001;
grant SELECT                                                                 on V_CUST_REL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_REL.sql =========*** End *** ===
PROMPT ===================================================================================== 
