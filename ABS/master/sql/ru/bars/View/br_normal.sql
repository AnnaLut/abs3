

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BR_NORMAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view BR_NORMAL ***

  CREATE OR REPLACE FORCE VIEW BARS.BR_NORMAL ("BR_ID", "BDATE", "KV", "RATE") AS 
  SELECT br_id, bdate, kv, rate
    FROM br_normal_edit;

PROMPT *** Create  grants  BR_NORMAL ***
grant SELECT                                                                 on BR_NORMAL       to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_NORMAL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BR_NORMAL       to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_NORMAL       to DPT_ADMIN;
grant SELECT                                                                 on BR_NORMAL       to KLBX;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_NORMAL       to SALGL;
grant SELECT                                                                 on BR_NORMAL       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_NORMAL       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BR_NORMAL       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BR_NORMAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
