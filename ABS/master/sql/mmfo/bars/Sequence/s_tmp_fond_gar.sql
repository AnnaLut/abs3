

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_TMP_FOND_GAR.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_TMP_FOND_GAR ***

   CREATE SEQUENCE  BARS.S_TMP_FOND_GAR  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_TMP_FOND_GAR ***
grant SELECT                                                                 on S_TMP_FOND_GAR  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_TMP_FOND_GAR.sql =========*** End
PROMPT ===================================================================================== 
