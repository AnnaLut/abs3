

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CHKLIST_TTS_UPDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CHKLIST_TTS_UPDATE ***

   CREATE SEQUENCE  BARS.S_CHKLIST_TTS_UPDATE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 794 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CHKLIST_TTS_UPDATE ***
grant SELECT                                                                 on S_CHKLIST_TTS_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CHKLIST_TTS_UPDATE.sql =========*
PROMPT ===================================================================================== 
