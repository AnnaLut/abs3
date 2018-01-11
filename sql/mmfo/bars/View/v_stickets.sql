

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STICKETS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STICKETS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STICKETS ("REF", "TICKET", "STIKET") AS 
  (select ref, get_stiket (ref), get_stiket_blob(ref)
      from cp_arch
     where stiket is not null);

PROMPT *** Create  grants  V_STICKETS ***
grant SELECT                                                                 on V_STICKETS      to BARSREADER_ROLE;
grant SELECT                                                                 on V_STICKETS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STICKETS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STICKETS.sql =========*** End *** ===
PROMPT ===================================================================================== 
