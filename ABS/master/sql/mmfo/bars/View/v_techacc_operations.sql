

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TECHACC_OPERATIONS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TECHACC_OPERATIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TECHACC_OPERATIONS ("OP_ID", "OP_NAME", "TT_MAIN_NC", "TT_MAIN_FC", "TT_COMISS") AS 
  select dpt_op.id, dpt_op.name, nvl(t.tt_nc, t.tt_fc), nvl(t.tt_fc,t.tt_nc), t.tt_commiss
  from dpt_op,
      (select r.val dptop,
              max(decode(substr(t.tt, 1, 1), 'K', null, decode(t.kv, 980, t.tt, null))) tt_nc,
       max(decode(substr(t.tt, 1, 1), 'K', null, decode(t.kv, 980, null, t.tt))) tt_fc,
              max(decode(substr(t.tt, 1, 1), 'K', t.tt, NULL)) tt_commiss
         from op_rules r,  tts t
        where r.tag = 'TECOP'
   and t.tt = r.tt
        group by r.val) t
 where trim(t.dptop) = to_char(dpt_op.id)
 ;

PROMPT *** Create  grants  V_TECHACC_OPERATIONS ***
grant SELECT                                                                 on V_TECHACC_OPERATIONS to BARSREADER_ROLE;
grant SELECT                                                                 on V_TECHACC_OPERATIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TECHACC_OPERATIONS to DPT_ROLE;
grant SELECT                                                                 on V_TECHACC_OPERATIONS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TECHACC_OPERATIONS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TECHACC_OPERATIONS.sql =========*** E
PROMPT ===================================================================================== 
