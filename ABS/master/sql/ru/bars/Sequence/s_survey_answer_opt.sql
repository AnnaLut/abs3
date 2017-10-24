

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SURVEY_ANSWER_OPT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SURVEY_ANSWER_OPT ***

   CREATE SEQUENCE  BARS.S_SURVEY_ANSWER_OPT  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SURVEY_ANSWER_OPT ***
grant SELECT                                                                 on S_SURVEY_ANSWER_OPT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_SURVEY_ANSWER_OPT to DPT_ADMIN;
grant SELECT                                                                 on S_SURVEY_ANSWER_OPT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SURVEY_ANSWER_OPT.sql =========**
PROMPT ===================================================================================== 
