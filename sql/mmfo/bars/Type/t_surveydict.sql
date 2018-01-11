
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_surveydict.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_SURVEYDICT IS TABLE OF t_surveydictrec
/

 show err;
 
PROMPT *** Create  grants  T_SURVEYDICT ***
grant EXECUTE                                                                on T_SURVEYDICT    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_surveydict.sql =========*** End *** =
 PROMPT ===================================================================================== 
 