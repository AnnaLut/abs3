
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_surveydictrec.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_SURVEYDICTREC IS OBJECT (id NUMBER(38), name VARCHAR2(100))
/

 show err;
 
PROMPT *** Create  grants  T_SURVEYDICTREC ***
grant EXECUTE                                                                on T_SURVEYDICTREC to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_surveydictrec.sql =========*** End **
 PROMPT ===================================================================================== 
 