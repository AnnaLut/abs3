
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_staff_015.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_STAFF_015 (p_userid NUMBER)
   RETURN INT
IS
   l_id   INT;
BEGIN
   SELECT s.id
     INTO l_id
   FROM staff$base s
    WHERE
      ( LENGTH (s.branch) =22)
          AND s.id = p_userid;
   RETURN 1;
EXCEPTION
   WHEN NO_DATA_FOUND     THEN
   RETURN 0;
        end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_staff_015.sql =========*** 
 PROMPT ===================================================================================== 
 