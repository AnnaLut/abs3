

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BR_TIER.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view BR_TIER ***

  CREATE OR REPLACE FORCE VIEW BARS.BR_TIER ("BR_ID", "BDATE", "KV", "S", "RATE") AS 
  SELECT br_id,
          bdate,
          kv,
          s,
          rate
     FROM br_tier_edit
    WHERE (branch, br_id, bdate, kv, s) IN
             (SELECT branch,
                     br_id,
                     bdate,
                     kv,
                     s
                FROM br_tier_edit
               WHERE branch = nvl( SYS_CONTEXT ('bars_context','user_branch'), f_ourmfo_g)
              UNION ALL
              SELECT b.branch,
                     b.br_id,
                     b.bdate,
                     b.kv,
                     b.s
                FROM br_tier_edit b
               WHERE b.branch =
                           '/'
                        ||  nvl(SYS_CONTEXT ('bars_context', 'user_mfo'), f_ourmfo_g)
                        || '/'
                     AND NOT EXISTS
                                (SELECT a.branch
                                   FROM br_tier_edit a
                                  WHERE a.branch = nvl( SYS_CONTEXT ('bars_context','user_branch'), f_ourmfo_g)
                                        AND a.br_id = b.br_id
                                        AND a.bdate = b.bdate
                                        AND a.kv = b.kv
                                        AND a.s = b.s)
              UNION ALL
              SELECT c.branch,
                     c.br_id,
                     c.bdate,
                     c.kv,
                     c.s
                FROM br_tier_edit c
               WHERE c.branch = '/'
                     AND NOT EXISTS
                                (SELECT d.branch
                                   FROM br_tier_edit d
                                  WHERE d.branch =
                                          nvl( SYS_CONTEXT ('bars_context','user_branch'), f_ourmfo_g)
                                        AND d.br_id = c.br_id
                                        AND d.bdate = c.bdate
                                        AND d.kv = c.kv
                                        AND d.s = c.s)
                     AND NOT EXISTS
                                (SELECT e.branch
                                   FROM br_tier_edit e
                                  WHERE e.branch =
                                           '/'
                                           || nvl(SYS_CONTEXT ('bars_context', 'user_mfo'), f_ourmfo_g)
                                           || '/'
                                        AND e.br_id = c.br_id
                                        AND e.bdate = c.bdate
                                        AND e.kv = c.kv
                                        AND e.s = c.s));

PROMPT *** Create  grants  BR_TIER ***
grant SELECT                                                                 on BR_TIER         to BARSUPL;
grant SELECT                                                                 on BR_TIER         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BR_TIER         to KLBX;
grant SELECT                                                                 on BR_TIER         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_TIER         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BR_TIER.sql =========*** End *** ======
PROMPT ===================================================================================== 
