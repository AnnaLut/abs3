

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SURVEY_QUEST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SURVEY_QUEST ***

   CREATE SEQUENCE  BARS.S_SURVEY_QUEST  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SURVEY_QUEST ***
grant SELECT                                                                 on S_SURVEY_QUEST  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SURVEY_QUEST.sql =========*** End
PROMPT ===================================================================================== 