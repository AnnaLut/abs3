

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_OPERATIONS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_OPERATIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_OPERATIONS ("OP_ID", "OP_NAME", "TT_MAIN_NC", "TT_MAIN_FC") AS 
  SELECT dpt_op.ID, dpt_op.NAME, NVL (t.tt_nc, t.tt_fc),
          NVL (t.tt_fc, t.tt_nc)
     FROM dpt_op,
          (SELECT   r.val dptop,
                    MAX (DECODE (SUBSTR (t.tt, 1, 1),
                                 'K', NULL,
                                 DECODE (t.kv, 980, t.tt, NULL)
                                )
                        ) tt_nc,
                    MAX (DECODE (SUBSTR (t.tt, 1, 1),
                                 'K', NULL,
                                 DECODE (t.kv, 980, NULL, t.tt)
                                )
                        ) tt_fc
               FROM op_rules r, tts t
              WHERE r.tag = 'DPTOP' AND t.tt = r.tt
           GROUP BY r.val) t
    WHERE TRIM (t.dptop) = TO_CHAR (dpt_op.ID)
 ;

PROMPT *** Create  grants  V_DPT_OPERATIONS ***
grant SELECT                                                                 on V_DPT_OPERATIONS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_OPERATIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_OPERATIONS to DPT_ROLE;
grant SELECT                                                                 on V_DPT_OPERATIONS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_OPERATIONS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_OPERATIONS.sql =========*** End *
PROMPT ===================================================================================== 
