
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_visa_bis.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_VISA_BIS (p_userid NUMBER)
   RETURN INT
IS
   l_id   INT;
BEGIN
   SELECT s.id
     INTO l_id
   FROM staff$base s
    WHERE
      (   --не рівень МФО
           LENGTH (s.branch) > 8
             -- або просто web користувач
           OR EXISTS
                 (SELECT 1
                    FROM web_usermap
                   WHERE dbuser = s.logname))
          AND s.id = p_userid;
   RETURN 1;
EXCEPTION
   WHEN NO_DATA_FOUND     THEN
   RETURN 0;
        end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_visa_bis.sql =========*** E
 PROMPT ===================================================================================== 
 