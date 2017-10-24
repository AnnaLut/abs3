

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SPEC1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view SPEC1 ***

  CREATE OR REPLACE FORCE VIEW BARS.SPEC1 ("ACC", "NLS", "KV", "NMS", "R011", "R013", "R016", "S080", "S180", "S181", "S190", "S240", "S260", "S270", "S120", "S580", "IDG", "IDS", "DAOS") AS 
  SELECT a.acc,
          a.nls,
          a.kv,
          a.nms,
          b.r011,
          b.r013,
          b.r016,    
          b.s080,
          b.s180,
          b.s181,
          b.s190,
          b.s240,
          b.s260,
          b.s270,
          b.s120,
          b.s580,
          b.idg,
          b.ids,
          a.daos
     FROM accounts a, specparam b
    WHERE a.acc = b.acc;

PROMPT *** Create  grants  SPEC1 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPEC1           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPEC1           to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPEC1           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPEC1           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SPEC1           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SPEC1.sql =========*** End *** ========
PROMPT ===================================================================================== 
