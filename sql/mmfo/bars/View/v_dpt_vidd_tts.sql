

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_VIDD_TTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_VIDD_TTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_VIDD_TTS ("DPTTYPE_ID", "DPTTYPE_NAME", "OP_TYPE", "OP_NAME", "TT_ID", "TT_NAME", "TT_CASH") AS 
  select v.vidd, v.type_name, t.tt, t.name, dpt_op.id, dpt_op.name,
       greatest(decode(t.sk, null, 0, 1),
               (select count(*) from op_rules where tt = t.tt and tag = 'D#73 '))
  from dpt_vidd v, dpt_tts_vidd tv, tts t, op_rules r, dpt_op
 where v.vidd = tv.vidd
   and tv.tt = t.tt
   and t.tt = r.tt
   and r.tag = 'DPTOP'
   and trim(r.val) = to_char(dpt_op.id)
   and t.tt not in
    (
        select tt
        from op_rules
        where tag = 'DPTOF'
        and val = '1'
    )
 ;

PROMPT *** Create  grants  V_DPT_VIDD_TTS ***
grant SELECT                                                                 on V_DPT_VIDD_TTS  to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_VIDD_TTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_VIDD_TTS  to DPT_ROLE;
grant SELECT                                                                 on V_DPT_VIDD_TTS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_VIDD_TTS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_VIDD_TTS.sql =========*** End ***
PROMPT ===================================================================================== 
