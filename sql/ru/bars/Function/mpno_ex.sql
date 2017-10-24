
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/mpno_ex.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.MPNO_EX (p_phone IN VARCHAR2, p_rnk in number) -- телефонный номер на проверку
   RETURN VARCHAR2                      -- РНК клиента+branch, с таким номером
IS
   l_title   CONSTANT VARCHAR2 (30) := 'mpno_ex:';
   p_res              VARCHAR2 (500);
BEGIN
   bars_audit.trace ('%s Start with %s.', l_title, p_phone);

   BEGIN
      SELECT substr(concatstr (TO_CHAR (cw.rnk) || '(' || (c.tobo)||')'),1,500)
        INTO p_res
        FROM customerw cw, customer c
       WHERE c.rnk = cw.rnk AND cw.tag = 'MPNO' AND cw.VALUE = p_phone and cw.rnk != p_rnk;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         p_res := '';
         bars_audit.trace ('%s no_data_found', l_title);
   END;


   bars_audit.trace ('%s End with rnk, tobo in (%s).', l_title, p_res);
   RETURN p_res;
END;
/
 show err;
 
PROMPT *** Create  grants  MPNO_EX ***
grant EXECUTE                                                                on MPNO_EX         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MPNO_EX         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/mpno_ex.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 