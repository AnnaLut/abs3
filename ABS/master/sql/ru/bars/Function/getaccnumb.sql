
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getaccnumb.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETACCNUMB 
   (p_tag branch_tags.tag%type)
RETURN VARCHAR2
IS
BEGIN
  RETURN branch_usr.get_branch_param(p_tag);
END;
/
 show err;
 
PROMPT *** Create  grants  GETACCNUMB ***
grant EXECUTE                                                                on GETACCNUMB      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETACCNUMB      to PYOD001;
grant EXECUTE                                                                on GETACCNUMB      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GETACCNUMB      to WR_DOC_INPUT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getaccnumb.sql =========*** End ***
 PROMPT ===================================================================================== 
 