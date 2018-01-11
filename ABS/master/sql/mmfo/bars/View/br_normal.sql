

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BR_NORMAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view BR_NORMAL ***

  CREATE OR REPLACE FORCE VIEW BARS.BR_NORMAL ("BR_ID", "BDATE", "KV", "RATE") AS 
  SELECT br_id,
          bdate,
          kv,
          rate
     FROM br_normal_edit
    WHERE (branch, br_id, bdate, kv) IN
             (SELECT branch,
                     br_id,
                     bdate,
                     kv
                FROM br_normal_edit
               WHERE branch = NVL (SYS_CONTEXT ('bars_context', 'user_branch'),f_ourmfo_g)
              UNION ALL
              SELECT b.branch,
                     b.br_id,
                     b.bdate,
                     b.kv
                FROM br_normal_edit b
               WHERE b.branch =
                           '/'
                        || NVL (SYS_CONTEXT ('bars_context', 'user_mfo'),f_ourmfo_g)
                        || '/'
                     AND NOT EXISTS
                                (SELECT a.branch
                                   FROM br_normal_edit a
                                  WHERE a.branch =NVL (SYS_CONTEXT ('bars_context', 'user_branch'),f_ourmfo_g)
                                        AND a.br_id = b.br_id
                                        AND a.bdate = b.bdate
                                        AND a.kv = b.kv)
              UNION ALL
              SELECT c.branch,
                     c.br_id,
                     c.bdate,
                     c.kv
                FROM br_normal_edit c
               WHERE c.branch = '/'
                     AND NOT EXISTS
                                (SELECT d.branch
                                   FROM br_normal_edit d
                                  WHERE d.branch =NVL (SYS_CONTEXT ('bars_context', 'user_branch'),f_ourmfo_g)
                                        AND d.br_id = c.br_id
                                        AND d.bdate = c.bdate
                                        AND d.kv = c.kv)
                     AND NOT EXISTS
                                (SELECT e.branch
                                   FROM br_normal_edit e
                                  WHERE e.branch =
                                           '/'
                                           || NVL (SYS_CONTEXT ('bars_context', 'user_mfo'),f_ourmfo_g)
                                           || '/'
                                        AND e.br_id = c.br_id
                                        AND e.bdate = c.bdate
                                        AND e.kv = c.kv));

PROMPT *** Create  grants  BR_NORMAL ***
grant SELECT                                                                 on BR_NORMAL       to BARSREADER_ROLE;
grant SELECT                                                                 on BR_NORMAL       to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_NORMAL       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_NORMAL       to DPT_ADMIN;
grant SELECT                                                                 on BR_NORMAL       to KLBX;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_NORMAL       to SALGL;
grant SELECT                                                                 on BR_NORMAL       to START1;
grant SELECT                                                                 on BR_NORMAL       to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_NORMAL       to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_NORMAL       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BR_NORMAL       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BR_NORMAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
