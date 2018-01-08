

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TTS_FLAGS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view TTS_FLAGS ***

  CREATE OR REPLACE FORCE VIEW BARS.TTS_FLAGS ("TT", "FCODE", "VALUE") AS 
  (
SELECT t.tt, to_number(SUBSTR(p.column_value,2,2)) fcode,to_number(SUBSTR(p.column_value,1,1)) value
  FROM tts t, TABLE("tts_flagS"(t.flags)) p )
 ;

PROMPT *** Create  grants  TTS_FLAGS ***
grant SELECT                                                                 on TTS_FLAGS       to ABS_ADMIN;
grant SELECT                                                                 on TTS_FLAGS       to BARSREADER_ROLE;
grant SELECT                                                                 on TTS_FLAGS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TTS_FLAGS       to OW;
grant SELECT                                                                 on TTS_FLAGS       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTS_FLAGS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TTS_FLAGS.sql =========*** End *** ====
PROMPT ===================================================================================== 
